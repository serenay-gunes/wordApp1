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

class QuizViewViewModel: ObservableObject {
    @Published var words: [Word] = []
    @Published var currentWordIndex: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var options: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchWords()
    }
    
    func fetchWords() {
        let db = Firestore.firestore()
        db.collection("words")
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    self.alertMessage = "Kelimeler alınırken hata oluştu: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }
                
                if let querySnapshot = querySnapshot {
                    self.words = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Word.self)
                    }
                    self.words.shuffle() // Kelimeleri rastgele sırala
                    self.setOptions()
                }
            }
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
        }
        
        if currentWordIndex < words.count - 1 {
            currentWordIndex += 1
            setOptions()
        } else {
            endQuiz()
        }
    }
    
    func endQuiz() {
        alertMessage = "Quiz bitti! Doğru cevaplar: \(correctAnswers) / \(words.count)"
        showAlert = true
    }
    
    func resetQuiz() {
        currentWordIndex = 0
        correctAnswers = 0
        words.shuffle()
        setOptions()
    }
}
