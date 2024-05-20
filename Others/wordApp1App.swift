//
//  wordApp1App.swift
//  wordApp1
//
//  Created by Serenay Güneş on 19.05.2024.
//

import SwiftUI
import Firebase

@main
struct wordApp1App: App {
    
    init() {
           FirebaseApp.configure()
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
