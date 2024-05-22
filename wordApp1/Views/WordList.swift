//
//  WordList.swift
//  wordApp1
//
//  Created by Serenay Güneş on 22.05.2024.
//

import SwiftUI



struct WordListView: View {
    @StateObject private var viewModel = WordListViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Yükleniyor...")
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.words) { word in
                    VStack(alignment: .leading) {
                        Text(word.english)
                            .font(.headline)
                        Text(word.turkish)
                            .font(.subheadline)
                        ForEach(word.sentences, id: \.self) { sentence in
                            Text(sentence)
                                .font(.body)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Kelimelerim")
            }
        }
        .onAppear {
            viewModel.fetchWords()
        }
    }
}


#Preview {
    WordListView()
}
