//
//  SettingsView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var datas: DataShared = .shared
    var language = LocalizationService.shared.language
    @State var isDatePickerPresented = false
    @FocusState var isKeyboardFocused: Bool
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Image("settingsBack")
                    .resizable()
                    .scaledToFill()
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            .edgesIgnoringSafeArea(.all)
            .scrollDisabled(true)
            
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            datas.view = "home"
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color(.white))
                            .font(.system(size: 20))
                            .padding(.leading, 16)
                            .frame(width: 30,height: 30)
                    }
                    
                    Spacer()
                    
                    Text("settings".localized(language))
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 20).weight(.semibold))
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("   ")
                            .font(.system(size: 20))
                            .padding(.trailing, 16)
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Button {
                            datas.languageSheet.toggle()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "globe")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                    .frame(width: 25)
                                
                                Text("language".localized(language))
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        Button {
                            withAnimation {
                                datas.view = "auth"
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                    .frame(width: 25)
                                
                                Text("exit".localized(language))
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: Color(.black).opacity(0.3),radius: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 30)
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 8) {
                            Image(systemName: "textformat.abc.dottedunderline")
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 15))
                                .frame(width: 25)
                            
                            TextField("name".localized(language), text: $datas.name)
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .focused($isKeyboardFocused)
                            
                            Spacer()
                            
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        HStack(spacing: 8) {
                            Image(systemName: "textformat.abc.dottedunderline")
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 15))
                                .frame(width: 25)
                            
                            TextField("surname".localized(language), text: $datas.surname)
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .focused($isKeyboardFocused)
                            
                            Spacer()
                            
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        HStack(spacing: 8) {
                            Image(systemName: "123.rectangle")
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16))
                                .frame(width: 25)
                            
                            Text("+998")
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 15))
                            
                            TextField("33 111 11 11", text: $datas.phone)
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .keyboardType(.numberPad)
                                .focused($isKeyboardFocused)
                                .onChange(of: datas.phone) { Value in
                                    if !datas.phone.isEmpty {
                                        datas.phone = datas.phone.formatPhoneNumber()
                                    }
                                }
                            Spacer()
                            
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        Button {
                            isDatePickerPresented.toggle()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Text("dateBirth".localized(language))
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: Color(.black).opacity(0.3),radius: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                    VStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            HStack(spacing: 8) {
                                Image("telegramIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                
                                Text("Telegram")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack(spacing: 8) {
                                Image("instagramIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                
                                Text("Instagram")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack(spacing: 8) {
                                Image("facebookIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                
                                Text("Facebook")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "message.badge.filled.fill")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Text("Support")
                                    .foregroundStyle(Color(.black))
                                    .font(.system(size: 16))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(height: 40)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: Color(.black).opacity(0.3),radius: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                    Spacer()
                }
            }
        }
        
        //Date Picker Sheet
        .sheet(isPresented: $isDatePickerPresented) {
            if #available(iOS 16.4, *) {
                VStack(spacing: 0) {
                    HStack {
                        Button("cancel".localized(language)) {
                            isDatePickerPresented = false
                        }
                        .padding()
                        
                        Spacer()
                        
                        Text("dateBirth".localized(language))
                            .font(.system(size: 17).weight(.semibold))
                        
                        Spacer()
                        
                        Button("done".localized(language)) {
                            isDatePickerPresented = false
                        }
                        .padding()
                    }
                    .frame(height: 44)
                    .background(Color(.systemGray5))
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.black).opacity(0.2))
                    
                    DatePicker("", selection: $datas.birthDate, in: ...Date.now, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .frame(maxHeight: .infinity)
                }
                .background(Color(.systemGray6))
                .background(.ultraThickMaterial)
                .presentationBackground(.clear)
                .presentationDetents([.height(318)])
                
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Button("cancel".localized(language)) {
                            isDatePickerPresented = false
                        }
                        .padding()
                        
                        Spacer()
                        
                        Text("dateBirth".localized(language))
                            .font(.system(size: 17).weight(.semibold))
                        
                        Spacer()
                        
                        Button("done".localized(language)) {
                            isDatePickerPresented = false
                        }
                        .padding()
                    }
                    .frame(height: 44)
                    .background(Color(.systemGray5))
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.black).opacity(0.2))
                    
                    DatePicker("", selection: $datas.birthDate, in: ...Date.now, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .frame(maxHeight: .infinity)
                }
                .background(Color(.systemGray6))
                .background(.ultraThickMaterial)
                .presentationDetents([.height(318)])
            }
        }
    }
}

#Preview {
    SettingsView()
}

