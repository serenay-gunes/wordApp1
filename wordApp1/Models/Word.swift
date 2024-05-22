//
//  Word.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//

import Foundation

struct Word: Codable {
    var english: String
    var turkish: String
    var sentences: [String]
    var imageUrl: String?
    var audioUrl: String?
}
