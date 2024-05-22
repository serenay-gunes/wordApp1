//
//  LoginViewViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import FirebaseAuth
import Foundation


class LoginViewViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){}
    
    
    func login() {
        
        guard validate() else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    
    func validate()-> Bool{
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            errorMessage = "Lütfen tüm alanları doldurun."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Lütfen geçerli bir mail adresi girin."
            return false
        }
        return true
    }
    
}
