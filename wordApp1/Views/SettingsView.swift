//
//  SettingsView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var quizSize: Int = 10

    var body: some View {
        Form {
            Section(header: Text("Quiz Ayarları")) {
                Stepper(value: $quizSize, in: 1...20) {
                    Text("Quiz Boyutu: \(quizSize)")
                }
            }

            Button(action: {
                // Quiz boyutu ayarlarını kaydet
            }) {
                Text("Kaydet")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Ayarlar")
    }
}

#Preview {
    SettingsView()
}
