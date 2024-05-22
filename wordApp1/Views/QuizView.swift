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
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if let currentWord = viewModel.currentWord {
                    VStack(spacing: 20) {
                        Text(currentWord.english)
                            .font(.largeTitle)
                            .padding()

                        Button(action: {
                            viewModel.markCorrect()
                        }) {
                            Text("Doğru")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            viewModel.markIncorrect()
                        }) {
                            Text("Yanlış")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }

                        Spacer()
                    }
                    .padding()
                } else {
                    Text("Quiz tamamlandı!")
                        .font(.largeTitle)
                        .padding()
                }
            }
            .navigationTitle("Quiz")
            .onAppear {
                viewModel.fetchWords()
            }
        }
    }
}


#Preview {
  QuizView()
}
