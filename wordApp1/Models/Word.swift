//
//  Word.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//


import Foundation
import FirebaseFirestoreSwift

struct Word: Identifiable, Codable {
    @DocumentID var id: String?
    var english: String
    var turkish: String
    var sentences: [String]
    var imageUrl: String?
    var audioUrl: String?
    var correctCount: Int = 0
    var lastCorrectDate: Date?
}
