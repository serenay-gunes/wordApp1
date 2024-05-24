//
//  ScoresView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 24.05.2024.
//

import SwiftUI

struct ScoresView: View {
    @StateObject private var viewModel = ScoresViewViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.scores) { score in
                VStack(alignment: .leading) {
                    Text("Tarih: \(score.date, formatter: dateFormatter)")
                        .font(.headline)
                    Text("Doğru Cevaplar: \(score.correctAnswers) / \(score.totalQuestions)")
                        .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle("Geçmiş Skorlar")
            .onAppear {
                viewModel.fetchScores()
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}



#Preview {
    ScoresView()
}
