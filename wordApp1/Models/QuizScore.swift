//
//  QuizScore.swift
//  wordApp1
//
//  Created by Serenay Güneş on 24.05.2024.
//

import Foundation
import FirebaseFirestoreSwift


struct QuizScore: Identifiable, Codable {
    @DocumentID var id: String?
    var date: Date
    var correctAnswers: Int
    var totalQuestions: Int
}
