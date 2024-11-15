//
//  SourceEKG.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct SourceEKG: View {
    @ObservedObject var data: DataShared = .shared
    @State var linksEKG = [
        sourceText(nomber: "1", link: "https://eurjmedres.biomedcentral.com/articles/10.1186/s40001-023-01065-y"),
        sourceText(nomber: "2", link: "https://pubmed.ncbi.nlm.nih.gov/34558666/"),
        sourceText(nomber: "3", link: "https://pubmed.ncbi.nlm.nih.gov/33308375/"),
        sourceText(nomber: "4", link: "https://www.hindawi.com/journals/crp/2020/4972346/"),
    ]
    private var language = LocalizationService.shared.language
    var body: some View {
        HStack(alignment: .center) {
            ForEach(linksEKG)  { texts in
                Link(destination: URL(string: texts.link)!)
                {
                    VStack {
                        Image(systemName: "\(texts.nomber).circle")
                            .foregroundColor(Color(.black))
                            .font(.system(size: 30))
                        Text("source".localized(language))
                            .foregroundColor(Color(.black))
                            .padding(1)
                            .underline()
                    }
                    .padding(2)
                }
                
            }
        }
    }
}

struct sourceText: Identifiable {
    let id = UUID()
    let nomber: String
    let link: String
}

struct SourceCardio: View {
    @ObservedObject var data: DataShared = .shared
    private var language = LocalizationService.shared.language
    @State var linksCardio = [
        sourceText(nomber: "1", link: "https://eurjmedres.biomedcentral.com/articles/10.1186/s40001-023-01065-y"),
        sourceText(nomber: "2", link: "https://pubmed.ncbi.nlm.nih.gov/34558666/"),
        sourceText(nomber: "3", link: "https://pubmed.ncbi.nlm.nih.gov/33308375/"),
        sourceText(nomber: "4", link: "https://www.hindawi.com/journals/crp/2020/4972346/"),
    ]
    var body: some View {
        HStack(alignment: .center) {
            ForEach(linksCardio)  { texts in
                Link(destination: URL(string: texts.link)!)
                {
                    VStack {
                        Image(systemName: "\(texts.nomber).circle")
                            .foregroundColor(Color(.black))
                            .font(.system(size: 30))
                        Text("source".localized(language))
                            .foregroundColor(Color(.black))
                            .padding(1)
                            .underline()
                    }
                    .padding(2)
                }
                
            }
        }
    }
}
