//
//  AddWordView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddWordView: View {
    @StateObject var view2Model = ProfileViewViewModel()
    @StateObject private var viewModel = AddWordViewModel()
    @State private var showImagePicker: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField("İngilizce Kelime", text: $viewModel.englishWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.blue.opacity(0.2)) // Light blue background color
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for text field

            TextField("Türkçe Karşılığı", text: $viewModel.turkishWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.blue.opacity(0.2)) // Light blue background color
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for text field

            TextField("Cümle 1", text: $viewModel.sentence1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.blue.opacity(0.2)) // Light blue background color
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for text field

            TextField("Cümle 2", text: $viewModel.sentence2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.blue.opacity(0.2)) // Light blue background color
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for text field

            TextField("Cümle 3", text: $viewModel.sentence3)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.blue.opacity(0.2)) // Light blue background color
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for text field

            Button(action: {
                self.showImagePicker = true
            }) {
                Text("Resim Yükle")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for button

            Button(action: viewModel.addWord) {
                Text("Kelime Ekle")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2) // Shadow for button
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all)) // Soft grey background
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Bilgi"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView()
    }
}
