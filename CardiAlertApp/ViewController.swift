//
//  ViewController.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct ViewController: View {
    @ObservedObject var datas: DataShared = .shared
    var body: some View {
        VStack {
            switch datas.view {
            case "auth": AuthView()
            case "home": HomeView()
            case "settings": SettingsView()
            case "ecg": SelfCheckECGView()
//            case "exo": HomeEXOView()
//            case "cvd": HomeCVDView()
            case "cardio": HomeCardioView()
            case "docHome": HomeDocView()
            case "sendAnalyze": SendAnalyzeView()
            case "patients": PatientsView()
            case "assistant": NeuroAssistantView()
//            case "locations": LocationsEKG()
                
            default: AuthView()
            }
        }
//        .background(LinearGradient(gradient: Gradient(colors: [Color("gradient1"), Color("gradient2"), Color("gradient3")]), startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.light)
//        .sheet(isPresented: $datas.languageSheet) {
//            if #available(iOS 16.4, *) {
//                LanguageSheet()
//                    .modifier(BottomViewModifier())
//                    .presentationBackground(.clear)
//            } else {
//                LanguageSheet()
//                    .modifier(BottomViewModifier())
//            }
//        }
    }
}

#Preview {
    ViewController()
}

