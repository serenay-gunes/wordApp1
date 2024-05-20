//
//  LoginView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import SwiftUI

struct LoginView: View {
//    @State var email = ""
//    @State var password = ""
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
    
        NavigationStack{
            VStack{
                // header
                HeaderView()
            
                //form- e-mail, sifre
                
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                    }
                    
                    TextField("Email giriniz." , text: $viewModel.email)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Şifre giriniz.", text: $viewModel.password)
                }
                .frame(height: 200)
                //alttaki iki satır video yorumlarından
                .background(Color.white)
                               .scrollContentBackground(.hidden)
                
                BigButton(title: "Giriş Yap") {viewModel.login()
                }
                Spacer()
                
                
                //footer- hesabınız yok mu
                VStack{
                    Text("Buralarda yeni misin?")
                    NavigationLink("Yeni hesap oluştur", destination: RegisterView())
                }
                .padding(.bottom, 150)
            }
        }
    }
}

#Preview {
    LoginView()
}
