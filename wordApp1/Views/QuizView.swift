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
        ZStack {
            Color.gray.opacity(0.2) // Soft grey background color
                .edgesIgnoringSafeArea(.all) // Ensure it covers the entire screen
            
            VStack {
                if let currentWord = viewModel.currentWord {
                    VStack {
                        Text(currentWord.english)
                            .font(.largeTitle)
                            .padding()
                        
                        ForEach(viewModel.options, id: \.self) { option in
                            Button(action: {
                                viewModel.checkAnswer(option)
                            }) {
                                Text(option)
                                    .padding()
                                    .frame(maxWidth: .infinity) // Button will take the maximum width available
                                    .background(Color.blue) // Button background color
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .padding(.vertical, 2)
                            }
                            .frame(width: 250) // Fixed width for buttons
                        }
                    }
                    .padding()
                    .background(Color.white) // Box background color
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding()
                    .frame(maxWidth: .infinity) // Make the box wider
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
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}


