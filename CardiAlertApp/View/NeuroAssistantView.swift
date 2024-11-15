//
//  NeuroAssistantView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import ChatGPTSwift

struct NeuroAssistantView: View {
    @ObservedObject var datas: DataShared = .shared
    let api = ChatGPTAPI(apiKey: "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")
    @State var text: String = ""
    @State var emptyText = false
    @State var errorMessage = false
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        datas.view = "home"
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(.black))
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("")
                }
            }
            .padding(.horizontal)
            
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(datas.messages) { item in
                        Text(item.text)
                            .foregroundColor(Color(.green))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        Divider()
                    }
                }
            }
            Spacer()
            HStack {
                TextField("Write a message...", text: $text)
                    .textFieldStyle(.roundedBorder)
                Button (action: {
                    if text == "" {
                        emptyText = true
                    }
                    else {
                        emptyText = false
                        sendMessage()
                    }
                }, label: {
                    Text("Send")
                        .foregroundColor(.white)
                })
                .padding(8)
                .background(Color(.green))
                .cornerRadius(10)
            }
            .padding(8)
            
        }
        .padding(.horizontal, 5)
        .background(Color(hex: "#F4F9FD").ignoresSafeArea())
        
        .alert("Please write something", isPresented: $emptyText, actions: {
            Button("Ok", role: .cancel, action: {

            })
        })
        .alert("An unknown error has occurred, please try again", isPresented: $errorMessage, actions: {
            Button("Ok", role: .cancel, action: {

            })
        })
    }
    func sendMessage() {
        let message = Message(text: text)
        datas.messages.append(message)
        Task {
            do {
                let response = try await api.sendMessage(text: text)
                //                print(response)
                let resp = Message(text: response)
                datas.messages.append(resp)
                text = ""
            } catch {
                print(error.localizedDescription)
                errorMessage.toggle()
            }
        }
    }
}

struct NeuroAssistantView_Previews: PreviewProvider {
    static var previews: some View {
        NeuroAssistantView()
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
}
