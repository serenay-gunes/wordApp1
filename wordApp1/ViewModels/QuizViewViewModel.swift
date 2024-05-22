//
//  QuizViewViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//



import Foundation
import Firebase
import SwiftUI
import FirebaseFirestore

class QuizViewViewModel: ObservableObject {
    @Published var words = [Word]()
    @Published var currentWord: Word?
    @Published var isLoading = true
    @Published var errorMessage: String = ""
    @Published var correctAnswerCount = 0
    @Published var quizSize: Int = 10

    private var userId: String? {
        Auth.auth().currentUser?.uid
    }

    init() {
        fetchWords()
    }

    func fetchWords() {
        guard let userId = userId else {
            self.errorMessage = "Kullanıcı oturumu açılmamış."
            self.isLoading = false
            return
        }

        let db = Firestore.firestore()
        db.collection("words")
            .order(by: "lastCorrectDate", descending: true)
            .limit(to: quizSize)
            .getDocuments { snapshot, error in
                if let error = error {
                    self.errorMessage = "Veriler alınırken hata oluştu: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }

                guard let documents = snapshot?.documents else {
                    self.errorMessage = "Veri bulunamadı."
                    self.isLoading = false
                    return
                }

                self.words = documents.compactMap { try? $0.data(as: Word.self) }
                self.isLoading = false
                self.nextWord()
            }
    }

    func nextWord() {
        if words.isEmpty {
            self.currentWord = nil
        } else {
            self.currentWord = words.removeFirst()
        }
    }

    func markCorrect() {
        guard let userId = userId, let currentWord = currentWord else { return }

        let db = Firestore.firestore()
        let wordRef = db.collection("users").document(userId).collection("words").document(currentWord.id!)

        var updatedWord = currentWord
        updatedWord.correctCount += 1
        updatedWord.lastCorrectDate = Date()

        do {
            try wordRef.setData(from: updatedWord)
            self.correctAnswerCount += 1
            nextWord()
        } catch {
            self.errorMessage = "Veri güncellenirken hata oluştu: \(error.localizedDescription)"
        }
    }

    func markIncorrect() {
        guard let userId = userId, let currentWord = currentWord else { return }

        let db = Firestore.firestore()
        let wordRef = db.collection("users").document(userId).collection("words").document(currentWord.id!)

        var updatedWord = currentWord
        updatedWord.correctCount = 0

        do {
            try wordRef.setData(from: updatedWord)
            nextWord()
        } catch {
            self.errorMessage = "Veri güncellenirken hata oluştu: \(error.localizedDescription)"
        }
    }
}
