//
//  RegisterView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import SwiftUI

struct RegisterView: View {
//    
//    @State var name = ""
//    @State var email = ""
//    @State var password = ""
    @StateObject var viewModel = RegisterViewViewModel()
 
    
    
    var body: some View {

        NavigationStack{
            VStack{
                //header bölümü
                HeaderView()
                Spacer()
                //register bolümü
                Form{
                    Section(header: Text("Kayıt Formu")) {
                        if !viewModel.errorMessage.isEmpty{
                            Text(viewModel.errorMessage)
                                .foregroundStyle(.red)
                        }
                        
                        TextField("Tam adınız:", text: $viewModel.name)
                            .autocorrectionDisabled()
                        TextField("Email adresiniz:", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        SecureField("Şifreniz:", text: $viewModel.password)
                    }
                }
                .frame(height: 250)
                //alttaki iki satır video yorumlarından
                .background(Color.white)
                               .scrollContentBackground(.hidden)
                Spacer()
              
                BigButton(title: "Kayıt Ol", action: {viewModel.register()})
                
                 Spacer()
                //footer
                VStack{
                    Text("Zaten bizden biri misin?")
                    NavigationLink("Şimdi giriş yap!", destination: LoginView())
                }
                .padding(.bottom, 150)
            }
        }

    }
}

#Preview {
    RegisterView()
}
