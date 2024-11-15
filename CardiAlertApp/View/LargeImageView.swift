//
//  LargeImageView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct LargeImageView: View {
    @ObservedObject var datas: DataShared = .shared
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                datas.largeImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            datas.showLargeImage.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.white)
                            .font(.title)
                    })
                }
                .padding(.horizontal, 32)
                Spacer()
            }
        }
        .background(Color(.black).opacity(0.7))
    }
}

#Preview {
    LargeImageView()
}
