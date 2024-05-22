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

            TextField("Türkçe Karşılığı", text: $viewModel.turkishWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Cümle 1", text: $viewModel.sentence1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Cümle 2", text: $viewModel.sentence2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Cümle 3", text: $viewModel.sentence3)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                self.showImagePicker = true
            }) {
                Text("Resim Yükle")
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$viewModel.image)
            }

            Button(action: viewModel.addWord) {
                Text("Kelime Ekle")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                
            BigButton(title: "Çıkış Yap"){ view2Model.logout()}

            }
            .padding()

            Spacer()
        }
        .padding()
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
