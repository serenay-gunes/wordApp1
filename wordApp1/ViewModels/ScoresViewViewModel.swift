//
//  ScoresViewViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 24.05.2024.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class ScoresViewViewModel: ObservableObject {
    @Published var scores: [QuizScore] = []

    init() {
        fetchScores()
    }

    func fetchScores() {
        let db = Firestore.firestore()
        db.collection("quizScores")
            .order(by: "date", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching quiz scores: \(error.localizedDescription)")
                    return
                }

                if let querySnapshot = querySnapshot {
                    self.scores = querySnapshot.documents.compactMap { document in
                        try? document.data(as: QuizScore.self)
                    }
                }
            }
    }
}
