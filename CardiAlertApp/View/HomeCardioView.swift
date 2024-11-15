//
//  HomeCardioView.swift
//  CardiAlertApp
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import PhotosUI

struct HomeCardioView: View {
    @ObservedObject var datas: DataShared = .shared
    @ObservedObject var PhotoUpload: GetApiCardio = .shared
    @State private var waiting = false
    @State private var pickPicture = false
    @State private var PhotoPicker = false
    @State private var showAbout = false
    private var language = LocalizationService.shared.language
    var body: some View {
        ZStack {
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
                
                Spacer()
                
                VStack {
                    if datas.ImageCardioPick == Image("photoExCardio") {
                        Text("upload_photo".localized(language))
                            .foregroundColor(Color(.black))
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        
                        ZStack {
                            datas.ImageCardioPick
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                        .scaledToFit()
                        .frame(width: 250)
                        .padding(2)
                        .background(Color(.systemGray3))
                        .cornerRadius(10)
                        .shadow(color: Color(.red).opacity(0.3), radius: 2, y: 2)
                    }
                    else {
                        Text("selected_photo".localized(language))
                            .foregroundColor(.black)
                            .foregroundColor(Color(.black))
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        ZStack {
                            datas.ImageCardioPick
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                                .padding(2)
                                .background(Color(.systemGray3))
                                .cornerRadius(10)
                                .shadow(color: Color(.red).opacity(0.3), radius: 2, y: 2)
                            if datas.waiting {
                                ProgressView()
                                    .frame(height: 210)
                            }
                        }
                        .frame(width: 250)
                    }
                }
                .padding(.top, 50)
                .onTapGesture {
                    if datas.ImageCardioPick == Image("photoExCardio") {
                        datas.largeImage = Image("photoExCardio")
                    }
                    else {
                        datas.largeImage = datas.ImageCardioPick
                    }
                    withAnimation {
                        datas.showLargeImage.toggle()
                    }
                }
                
                Image(systemName: "arrowshape.up")
                    .foregroundColor(Color(hex: "#ff646c"))
                    .padding(.top, 8)
                    .font(.title2)
                
                Text("upload_real_photo_cardio".localized(language))
                    .foregroundColor(.black)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.black).opacity(0.3),radius: 5)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 0) {
                    PhotosPicker(selection: $datas.ImageCardioItem, matching: .images) {
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
                    
                    Divider()
                    
                    Button {
                        if datas.ImageCardioPick == Image("photoExCardio") {
                            pickPicture.toggle()
                        }
                        else {
                            pickPicture = false
                            datas.waiting = true
                            PhotoUpload.uploadImageToServer()
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image("magnify")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 20)
                            
                            Text("get_result".localized(language))
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
                        showAbout.toggle()
                    } label: {
                        HStack(spacing: 8) {
                            Image("info")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 20)
                            
                            Text("about_cardio".localized(language))
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
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Spacer()
                    .sheet(isPresented: $showAbout) {
                        AboutCardioView()
                    }
                    .onChange(of: datas.ImageCardioItem) { _ in
                        Task {
                            if let data = try? await datas.ImageCardioItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    datas.ImageCardioPick = Image(uiImage: uiImage)
                                    return
                                    
                                }
                            }
                            print("Failed")
                        }
                    }
                
                    .alert("please_select_photo".localized(language), isPresented: $pickPicture, actions: {
                        Button("ok".localized(language), role: .cancel, action: {
                            
                        })
                    })
                
                    .alert("result_of_photo".localized(language), isPresented: $datas.showResultCardioPhotoPick, actions: {
                        Button("ok".localized(language), role: .cancel, action: {
                            
                        })
                    }, message: {
                        if datas.resultCardioApi == "No" {
                            Text("cardio_No".localized(language))
                                .multilineTextAlignment(.leading)
                        }
                        if datas.resultCardioApi == "Yes" {
                            Text("cardio_Yes".localized(language))
                                .multilineTextAlignment(.leading)
                        }
                        else {
                            Text("error".localized(language))
                                .multilineTextAlignment(.leading)
                        }
                    })
                
                    .alert("terms_of_use".localized(language), isPresented: $datas.alertButton, actions: {
                        Button("agree".localized(language), role: .cancel, action: { datas.checkButton = true })
                        Button("not_agree".localized(language), role: .destructive, action: { datas.checkButton = false })
                    }, message: {
                        Text("this_is_test".localized(language))
                    })
            }
            .background(Color(hex: "#F4F9FD").ignoresSafeArea())
            LargeImageView()
                .scaleEffect(self.datas.showLargeImage ? 1.0 : 0.0)
        }
    }
}

#Preview {
    HomeCardioView()
}
