//
//  User.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import Foundation

struct User: Codable{
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
