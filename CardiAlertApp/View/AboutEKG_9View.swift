//
//  AboutEKG_9View.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct AboutEKG_9View: View {
    private var language = LocalizationService.shared.language
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 5) {
                Text("ecg_9_about_title".localized(language))
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .padding(.top, 10)
                
                Text("ecg_9_about".localized(language))
                    .font(.system(size: 16))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.leading)
                HStack {
                    Spacer()
                    Text("ecg_9_shows_title".localized(language))
                        .fontWeight(.bold)
                        .font(.system(size: 19))
                        .foregroundColor(Color("text"))
                        .multilineTextAlignment(.leading)
                        .padding(5)
                    Spacer()
                }
                
                Text("ecg_9_shows".localized(language))
                    .font(.system(size: 16))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.leading)
                
                Text("ecg_9_contraindications_title".localized(language))
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.leading)
                    .padding(5)
                
                Text("ecg_9_contraindications".localized(language))
                    .font(.system(size: 16))
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.leading)
                
                SourceEKG()
                    .padding(.top)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(.white)
    }
}

#Preview {
    AboutEKG_9View()
}
