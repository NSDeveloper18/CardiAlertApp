//
//  AuthView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var datas: DataShared = .shared
    var language = LocalizationService.shared.language
    @FocusState var isKeyboardFocused: Bool
    @State private var isExistingUser = true
    @State private var email = ""
    @State private var password = ""
    @State private var reEnterPassword = ""
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundStyle(Color(hex: "ff646c"))
                    .frame(width: .infinity, height: 50)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            ScrollView(.vertical) {
                Image("settingsBack")
                    .resizable()
                    .scaledToFill()
                    .offset(y: 25)
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            .edgesIgnoringSafeArea(.all)
            .scrollDisabled(true)
            
            VStack(spacing: 0) {
                // Heart Icon and Background Elements
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .offset(y: -10)
                Spacer()
                
                HStack {
                    ZStack {
                        HStack {
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 40)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                        .offset(x: isExistingUser ? -92 : 92)
                        
                        HStack {
                            Button {
                                withAnimation {
                                    isExistingUser = true
                                }
                                
                            } label: {
                                Text("existing".localized(language))
                                    .foregroundStyle(isExistingUser ? Color.black : Color.white)
                                    .font(.system(size: 15).weight(.bold))
                                    .padding(.vertical, 10)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                            }
                            .frame(height: 40)
                            .clipShape(Capsule())
                            
                            
                            Button {
                                withAnimation {
                                    isExistingUser = false
                                }
                            } label: {
                                Text("new".localized(language))
                                    .foregroundStyle(!isExistingUser ? Color.black : Color.white)
                                    .font(.system(size: 15).weight(.bold))
                                    .padding(.vertical, 10)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                            }
                            .frame(height: 40)
                            .clipShape(Capsule())
                        }
                        
                    }
                }
                .background(Color.black.opacity(0.2))
                .clipShape(Capsule())
                
                // Form based on the picker selection
                VStack {
                    if isExistingUser {
                        existingUserForm
                    } else {
                        newUserForm
                    }
                }
                .frame(height: 300)
                .padding(.top, 16)
                
                Spacer()
                if !isKeyboardFocused {
                    HStack {
                        Button {
                            datas.languageSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "globe")
                                    .foregroundStyle(Color(.systemGray))
                                
                                Text("editLanguage".localized(language))
                                    .foregroundStyle(Color(.systemGray))
                                    .underline()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    // Existing User Login Form
    var existingUserForm: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(Color(.systemGray))
                        .padding(.leading, 8)
                        .frame(width: 20)
                    
                    TextField("enterEmail".localized(language), text: $email)
                        .foregroundStyle(.black)
                        .focused($isKeyboardFocused)
                }
                .padding(.horizontal, 8)
                .frame(height: 50)
                
                Divider()
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Image(systemName: "lock")
                        .foregroundStyle(Color(.systemGray))
                        .padding(.leading, 8)
                        .frame(width: 20)
                    
                    SecureField("password".localized(language), text: $password)
                        .foregroundStyle(.black)
                        .focused($isKeyboardFocused)
                }
                .padding(.horizontal, 8)
                .frame(height: 50)
            }
            .padding(.top, 16)
            .padding(.bottom, 50)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .padding(.horizontal, 16)
            .overlay() {
                VStack {
                    Spacer()
                    Button(action: {
                        // Login action
                        if email == "Doctor" && password == "doctor" {
                            withAnimation {
                                datas.view = "docHome"
                            }
                        }
                        else {
                            withAnimation {
                                datas.view = "home"
                            }
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("signIn".localized(language))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(.horizontal, 70)
                        .shadow(color: Color(.black).opacity(0.2), radius: 4, x: 0, y: -3)
                    }
                }
                .offset(x: 0, y: 25)
            }
            
            Button(action: {
                
            }) {
                Text("forgotPassword".localized(language))
                    .font(.system(size: 16).weight(.semibold))
                    .foregroundColor(Color(.systemGray2))
                    .underline()
            }
            .padding(.top, 40)
            
            Spacer()
        }
        .frame(height: 300)
    }
    
    // New User Signup Form
    var newUserForm: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(Color(.systemGray))
                        .padding(.leading, 8)
                        .frame(width: 20)
                    
                    TextField("enterEmail".localized(language), text: $email)
                        .foregroundStyle(.black)
                        .focused($isKeyboardFocused)
                }
                .padding(.horizontal, 8)
                .frame(height: 50)
                
                Divider()
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Image(systemName: "lock")
                        .foregroundStyle(Color(.systemGray))
                        .padding(.leading, 8)
                        .frame(width: 20)
                    
                    SecureField("password".localized(language), text: $password)
                        .foregroundStyle(.black)
                        .focused($isKeyboardFocused)
                }
                .padding(.horizontal, 8)
                .frame(height: 50)
                
                Divider()
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Image(systemName: "lock")
                        .foregroundStyle(Color(.systemGray))
                        .padding(.leading, 8)
                        .frame(width: 20)
                    
                    SecureField("re-enter".localized(language), text: $reEnterPassword)
                        .foregroundStyle(.black)
                        .focused($isKeyboardFocused)
                }
                .padding(.horizontal, 8)
                .frame(height: 50)
            }
            .padding(.top, 16)
            .padding(.bottom, 50)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .padding(.horizontal, 16)
            .overlay() {
                VStack {
                    Spacer()
                    Button(action: {
                        // Login action
                    }) {
                        HStack {
                            Spacer()
                            Text("signUp".localized(language))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(.horizontal, 70)
                        .shadow(color: Color(.black).opacity(0.2), radius: 4, x: 0, y: -3)
                    }
                }
                .offset(x: 0, y: 25)
            }
            
            Spacer()
        }
        .padding(.bottom, 16)
        .frame(height: 300)
    }
}

#Preview {
    AuthView()
}
