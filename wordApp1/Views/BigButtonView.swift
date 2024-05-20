//
//  BigButtonView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import SwiftUI

struct BigButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.primary)
                Text(title)
                    .foregroundStyle(.white)
            }
        })
        .frame(height: 50)
        .padding(.horizontal)
        
        
    }
}

#Preview {
    BigButton(title: "Örnek Buton", action: {})
}
