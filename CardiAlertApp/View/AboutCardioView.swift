//
//  AboutCardioView.swift
//  CardiAlertApp
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct AboutCardioView: View {
    private var language = LocalizationService.shared.language
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("about_cardio_title".localized(language))
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .padding()
                Text("about_cardio_body".localized(language))
                    .font(.system(size: 16))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.leading)
                
                SourceCardio()
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color("background").ignoresSafeArea())
    }
}

#Preview {
    AboutCardioView()
}
