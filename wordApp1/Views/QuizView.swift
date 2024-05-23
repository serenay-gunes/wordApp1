//
//  QuizView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//




import SwiftUI

struct QuizView: View {
    @StateObject private var viewModel = QuizViewViewModel()
    
    var body: some View {
        VStack {
            if let currentWord = viewModel.currentWord {
                Text(currentWord.english)
                    .font(.largeTitle)
                    .padding()
                
                ForEach(viewModel.options, id: \.self) { option in
                    Button(action: {
                        viewModel.checkAnswer(option)
                    }) {
                        Text(option)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.vertical, 2)
                    }
                }
            } else {
                Text("Yükleniyor...")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Quiz Bitti"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Tamam"), action: {
                viewModel.resetQuiz()
            }))
        }
        .onAppear {
            viewModel.fetchWords()
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
