//
//  ProfileView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//
import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Profil yükleniyor..")
                }
             
                // Logout işlemi yapılacak
                Button(action: {
                    viewModel.logout()
                }) {
                    Text("Çıkış Yap")
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        .padding(.top, 10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5) // Gölgeli button
                }
                
                // ScoresView'a geçiş
                NavigationLink(destination: ScoresView()) {
                    Text("Geçmiş Skorlar")
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        .padding(.top, 10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5) // Gölgeli button
                }
            }
            .padding()
            .navigationTitle("Profil")
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all)) // Soft grey background
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

@ViewBuilder
func profile(user: User) -> some View {
    VStack(spacing: 20) {
        Image(systemName: "person.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .foregroundColor(.black)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5) // Gölgeli profil resmi
        
        VStack(alignment: .leading, spacing: 5) {
            Text("İsim: \(user.name)")
            Text("Mail: \(user.email)")
            Text("Kayıt Tarihi: \(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
        }
        .foregroundColor(.black)
        .font(.body)
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

