//
//  HeaderView.swift
//  wordApp1
//
//  Created by Serenay Güneş on 20.05.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack{
            Image("icon-4")
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit() // Görselin orantılı şekilde yeniden boyutlandırılması

            Text("DenemeApp")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundColor(.black) // Metin rengi ekleme

               // .padding(.top, 10)
        }.padding(.top, 100)
    }
}

#Preview {
    HeaderView()
}
