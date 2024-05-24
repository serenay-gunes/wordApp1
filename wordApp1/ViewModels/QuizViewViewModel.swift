//
//  QuizViewViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import FirebaseAuth

class QuizViewViewModel: ObservableObject {
    @Published var words: [Word] = []
    @Published var currentWordIndex: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var options: [String] = []
    @Published var quizSize: Int = 4 // Varsayılan quiz boyutu
    
 
    
    private var cancellables = Set<AnyCancellable>()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    private var correctWordIds: Set<String> = [] // Doğru cevaplanan kelime kimliklerini saklar
    
    init() {
        loadQuizSize()
        fetchWords()
    }
    
    func loadQuizSize() {
        quizSize = UserDefaults.standard.integer(forKey: "QuizSize")
        if quizSize == 0 {
            quizSize = 4// Varsayılan değer
        }
    }
    
    func fetchWords() {
        let db = Firestore.firestore()
        db.collection("words")
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    self.alertMessage = "Kelimeler alınırken hata oluştu: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }
                
                if let querySnapshot = querySnapshot {
                    let allWords = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Word.self)
                    }
                    self.words = self.filterWords(allWords)
                    self.words.shuffle()
                    self.words = Array(self.words.prefix(self.quizSize)) // Quiz boyutuna göre sınırla
                    self.setOptions()
                }
            }
    }
    
    func filterWords(_ allWords: [Word]) -> [Word] {
        // Daha önce doğru cevaplanan kelimeleri filtrele
        let filteredWords = allWords.filter { word in
            return !correctWordIds.contains(word.id ?? "")
        }
        return filteredWords
    }
    
    var currentWord: Word? {
        guard currentWordIndex < words.count else { return nil }
        return words[currentWordIndex]
    }
    
    func setOptions() {
        guard let currentWord = currentWord else { return }
        var incorrectAnswers = words.filter { $0.turkish != currentWord.turkish }.map { $0.turkish }
        incorrectAnswers.shuffle()
        options = [currentWord.turkish, incorrectAnswers.first ?? ""].shuffled()
    }
    
    func checkAnswer(_ answer: String) {
        guard let currentWord = currentWord else { return }
        
        if answer == currentWord.turkish {
            correctAnswers += 1
            markWordAsCorrect(currentWord)
        }
        
        if currentWordIndex < words.count - 1 {
            currentWordIndex += 1
            setOptions()
        } else {
            endQuiz()
        }
    }
    
    func markWordAsCorrect(_ word: Word) {
        let db = Firestore.firestore()
        var updatedWord = word
        updatedWord.isLearning = true
        updatedWord.replyDate = Date()
        if let id = updatedWord.id {
            do {
                try db.collection("words").document(id).setData(from: updatedWord)
                correctWordIds.insert(id) // Doğru cevaplanan kelime kimliğini ekle
            } catch {
                print("Error updating word: \(error.localizedDescription)")
            }
        }
    }
    
    func endQuiz() {
        alertMessage = "Quiz bitti! Doğru cevaplar: \(correctAnswers) / \(words.count)"
        showAlert = true
        saveQuizScore()
    }
    
    func resetQuiz() {
        currentWordIndex = 0
        correctAnswers = 0
        fetchWords()
    }
    
    private func saveQuizScore() {
        let db = Firestore.firestore()
        let score = QuizScore(date: Date(), correctAnswers: correctAnswers, totalQuestions: words.count)
        
        do {
            try db.collection("quizScores").addDocument(from: score)
        } catch let error {
            print("Error saving quiz score: \(error.localizedDescription)")
        }
    }
}
