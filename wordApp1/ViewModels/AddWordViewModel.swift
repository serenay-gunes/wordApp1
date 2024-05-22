//
//  AddWordViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AddWordViewModel: ObservableObject {
    @Published var englishWord: String = ""
    @Published var turkishWord: String = ""
    @Published var sentence1: String = ""
    @Published var sentence2: String = ""
    @Published var sentence3: String = ""
    @Published var image: UIImage? = nil
    @Published var audioUrl: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func addWord() {
        guard !englishWord.isEmpty, !turkishWord.isEmpty else {
            self.alertMessage = "İngilizce ve Türkçe kelime alanları boş bırakılamaz."
            self.showAlert = true
            return
        }

        let sentences = [sentence1, sentence2, sentence3].filter { !$0.isEmpty }
        let word = Word(id: "id", english: englishWord, turkish: turkishWord, sentences: sentences, imageUrl: nil, audioUrl: audioUrl)

        saveWordToFirebase(word: word)
    }

//    private func saveWordToFirebase(word: Word) {
//        let db = Firestore.firestore()
//        do {
//            try db.collection("words").addDocument(from: word) { error in
//                if let error = error {
//                    self.alertMessage = "Kelime eklenirken hata oluştu: \(error.localizedDescription)"
//                    self.showAlert = true
//                } else {
//                    self.alertMessage = "Kelime başarıyla eklendi!"
//                    self.showAlert = true
//                    self.resetForm()
//                }
//            }
//        } catch let error {
//            self.alertMessage = "Kelime eklenirken hata oluştu: \(error.localizedDescription)"
//            self.showAlert = true
//        }
//    }
    private func saveWordToFirebase(word: Word) {
           guard let userId = Auth.auth().currentUser?.uid else {
               self.alertMessage = "Kullanıcı oturumu açılmamış."
               self.showAlert = true
               return
           }

        let db = Firestore.firestore()
        do {
            //try db.collection("users").document(userId).collection("words").addDocument(from: word) { error in
            try db.collection("words").addDocument(from: word) { error in
                if let error = error {
                    self.alertMessage = "Kelime eklenirken hata oluştu: \(error.localizedDescription)"
                    self.showAlert = true
                } else {
                    self.alertMessage = "Kelime başarıyla eklendi!"
                    self.showAlert = true
                    self.resetForm()
                }
            }
        } catch let error {
            self.alertMessage = "Kelime eklenirken hata oluştu: \(error.localizedDescription)"
            self.showAlert = true
        }
    }
    
    private func resetForm() {
        self.englishWord = ""
        self.turkishWord = ""
        self.sentence1 = ""
        self.sentence2 = ""
        self.sentence3 = ""
        self.image = nil
        self.audioUrl = ""
    }
}
