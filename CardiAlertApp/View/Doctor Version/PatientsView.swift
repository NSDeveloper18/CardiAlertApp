//
//  PatientsView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct PatientsView: View {
    @ObservedObject var datas: DataShared = .shared
    var language = LocalizationService.shared.language
    var patients = [
        patientsModel(id: 1, name: "Rashod", surname: "Akramov", phone_number: "+998909162868", date: "22.09.2024", time: "10:00"),
        patientsModel(id: 2, name: "Bobomurod", surname: "Mamadaliev", phone_number: "+998949152508", date: "22.09.2024", time: "11:00"),
        patientsModel(id: 3, name: "Shakhzod", surname: "Botirov", phone_number: "+998938121318", date: "22.09.2024", time: "12:00"),
        patientsModel(id: 4, name: "Yulya", surname: "", phone_number: "+998909998877", date: "22.09.2024", time: "14:00"),
        
    ]
    var body: some View {
        ZStack {
            Image("settingsBack")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(patients, id: \.id) { item in
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "line.3.horizontal.button.angledtop.vertical.right.fill")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16).weight(.medium))
                                    .padding(.trailing, 2)
                                
                                Text(item.name)
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 17).weight(.semibold))
                                
                                Text(item.surname)
                                    .foregroundStyle(Color(.black).opacity(0.9))
                                    .font(.system(size: 16).weight(.medium))
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "clock.badge")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16).weight(.medium))
                                    .padding(.trailing, 2)
                                
                                Text(item.date)
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 17).weight(.semibold))
                                
                                Text(item.time)
                                    .foregroundStyle(Color(.black).opacity(0.9))
                                    .font(.system(size: 16).weight(.medium))
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "phone.fill")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16).weight(.medium))
                                    .padding(.trailing, 2)
                                
                                Text(item.phone_number)
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 17).weight(.semibold))
                                
                                Spacer()
                            }
                            Link(destination: URL(string: "tel://\(item.phone_number)")!) {
                                HStack {
                                    Spacer()
                                    
                                    Text("call".localized(language))
                                        .foregroundStyle(Color(.black))
                                        .font(.system(size: 17).weight(.semibold))
                                    
                                    Spacer()
                                }
                                .frame(height: 40)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .padding(.top, 8)
                            }
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(16)
                        .shadow(color: Color(.black).opacity(0.3), radius: 3, y: 3)
                    }
                    
                }
                .padding(.top, 50)
                .padding(.horizontal, 32)
            }
            
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            datas.view = "docHome"
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color(.white))
                            .font(.system(size: 20))
                            .frame(width: 30,height: 30)
                    }
                    
                    Spacer()
                    
                    Text("Patients")
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 16))
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("")
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, 32)
                .background(Color(hex: "ff646c").opacity(0.7))
                .background(.ultraThinMaterial)
               
                .padding(.top, -10)
                
                Spacer()
            }
        }
    }
}

struct patientsModel {
    let id: Int
    let name: String
    let surname: String
    let phone_number: String
    let date: String
    let time: String
}

#Preview {
    PatientsView()
}
