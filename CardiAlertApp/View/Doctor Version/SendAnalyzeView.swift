//
//  SendAnalyzeView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import PhotosUI

struct SendAnalyzeView: View {
    @ObservedObject var datas: DataShared = .shared
    var language = LocalizationService.shared.language
    @State var isDatePickerPresented = false
    @FocusState var isKeyboardFocused: Bool
    
    @State var name = ""
    @State var surname = ""
    @State var phone = ""
    @State var result = ""
    @State var comment = ""
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Image("settingsBack")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
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
                            datas.view = "docHome"
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color(.white))
                            .font(.system(size: 20))
                            .padding(.leading, 16)
                            .frame(width: 30,height: 30)
                    }
                    
                    Spacer()
                    
                    Text("sendAnalyze".localized(language))
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
                
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image(systemName: "textformat.abc.dottedunderline")
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 15))
                            .frame(width: 25)
                        
                        TextField("name".localized(language), text: $name)
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
                        
                        TextField("surname".localized(language), text: $surname)
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
                        
                        TextField("33 111 11 11", text: $phone)
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 16))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.numberPad)
                            .focused($isKeyboardFocused)
                            .onChange(of: phone) { Value in
                                if !phone.isEmpty {
                                    phone = phone.formatPhoneNumber()
                                }
                            }
                        Spacer()
                        
                    }
                    .frame(height: 40)
                    
                    Divider()
                    
                    HStack(spacing: 8) {
                        Image(systemName: "heart.text.square")
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 16))
                            .frame(width: 25)
                        
                        TextField("resultAnalyze".localized(language), text: $result)
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 16))
                            .multilineTextAlignment(.leading)
                            .focused($isKeyboardFocused)
                        
                        Spacer()
                        
                    }
                    .frame(height: 40)
                    
                    Divider()
                    
                    HStack(spacing: 8) {
                        Image(systemName: "message.badge.filled.fill")
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 16))
                            .frame(width: 25)
                        
                        TextField("comment".localized(language), text: $comment)
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 16))
                            .multilineTextAlignment(.leading)
                            .focused($isKeyboardFocused)
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
                    
                    Divider()
                    
                    PhotosPicker(selection: $datas.ImageItemECG9, matching: .images) {
                        HStack(spacing: 8) {
                            Image("folder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 20)
                            
                            Text("select_photo".localized(language))
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16))
                                .fixedSize(horizontal: true, vertical: false)
                            
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
                
                VStack {
                    if datas.ImagePickECG9 == Image("photoEx") { }
                    else {
                        datas.ImagePickECG9
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(height: 250)
                            .shadow(color: Color(.black).opacity(0.3), radius: 5, y: 4)
                    }
                }
                .onTapGesture {
                    if datas.ImagePickECG9 == Image("photoEx") {
                        datas.largeImage = Image("photoEx")
                    }
                    else {
                        datas.largeImage = datas.ImagePickECG9
                    }
                    withAnimation {
                        datas.showLargeImage.toggle()
                    }
                }
                
                Spacer()
                
                if !isKeyboardFocused {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("sendAnalyze".localized(language))
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16).weight(.semibold))
                            
                            Spacer()
                            
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(Color(.black))
                                .font(.system(size: 16).weight(.semibold))
                        }
                        .padding(.horizontal, 14)
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(14)
                        .shadow(color: Color(.black).opacity(0.2), radius: 2, y: 2)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
            
            LargeImageView()
                .scaleEffect(self.datas.showLargeImage ? 1.0 : 0.0)
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: datas.ImageItemECG9) { _ in
            Task {
                if let data = try? await datas.ImageItemECG9?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        datas.ImagePickECG9 = Image(uiImage: uiImage)
                        return
                        
                    }
                }
                print("Failed")
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
    SendAnalyzeView()
}
