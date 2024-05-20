//
//  RegisterViewViewModel.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation


class RegisterViewViewModel: ObservableObject{
    
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    
    init(){}
    
    func register(){
        guard validate() else{
            return
        }
        
        //buraya
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result, error in
            guard let userId =  result?.user.uid else{
                return
            }
            //insert metodu çağırılacak
            
            
        }
    }
    
    private func insertUserRecord(id: String){
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
                errorMessage = "Lütfen tüm alanları doldurun."
                return false
        }
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Lütfen geçerli bir mail adresi girin."
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Lütfen 6 veya daha fazla karakterden oluşan bir şifre belirleyin."
            return false
        }
        return true
    }
}

