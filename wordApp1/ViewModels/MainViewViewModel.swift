//
//  MainViewViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Foundation

//class MainViewViewModel: ObservableObject {
//    @Published var currentUserId: String = ""
//
//    init() {
//        Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            DispatchQueue.main.async {
//                self?.currentUserId = user?.uid ?? ""
//            }
//        }
//    }
//
//    public var isSignedIn: Bool {
//        return Auth.auth().currentUser != nil
//    }
//}


class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var isSignedIn: Bool = false
    @Published var isLoading: Bool = true

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
                self?.isSignedIn = user != nil
                self?.isLoading = false
            }
        }
    }
}
