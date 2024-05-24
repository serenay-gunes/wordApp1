//
//  ProfileView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import SwiftUI




import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    init() {}

    var body: some View {
        NavigationView {
            VStack {
                
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Profil yükleniyor..")
                }
             
                // Logout işlemi yapılacak
                BigButton(title: "Çıkış Yap") {
                    viewModel.logout()
                }
                
                // ScoresView'a geçiş
                NavigationLink(destination: ScoresView()) {
                    Text("Geçmiş Skorlar")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 10)
                }
                
            }
            .navigationTitle("Profil")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

@ViewBuilder
func profile(user: User) -> some View {
    Image(systemName: "person.circle.fill")
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundColor(.black)
    // Diğer profil bilgilerini burada ekleyebilirsiniz
    
    VStack {
        HStack {
            Text("İsim:")
            Text(user.name)
        }
        HStack {
            Text("Mail:")
            Text(user.email)
        }
        HStack {
            Text("Kayıt Tarihi")
            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
        }
    }
}

 

//
//struct ProfileView: View {
//    @StateObject var viewModel = ProfileViewViewModel()
//
//    init() {}
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                
//                if let user = viewModel.user{
//                    profile(user: user)
//                } else{
//                    Text("Profil yükleniyor..")
//                }
//             
//                //logout islemi yapılacak
//                
//                BigButton(title: "Çıkış Yap"){ viewModel.logout()}
//                
//            }
//            .navigationTitle("Profil")
//        }
//        .onAppear{viewModel.fetchUser()}
//    }
//}
//
//@ViewBuilder
//func profile(user: User) -> some View{
//    Image(systemName: "person.circle.fill")
//        .resizable()
//        .frame(width: 100, height: 100)
//        .foregroundColor(.black)
//    // Diğer profil bilgilerini burada ekleyebilirsiniz
//    
//       VStack{
//           HStack{
//               Text("İsim:")
//               Text(user.name)
//           }
//           HStack{
//               Text("Mail:")
//               Text(user.email)
//           }
//           HStack{
//               Text("Kayıt Tarihi")
//               Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
//           }
//       }
//    
//}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

