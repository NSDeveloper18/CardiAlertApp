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
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        
                        ZStack {
                            datas.ImageCardioPick
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                        .scaledToFit()
                        .frame(width: 180)
                        .padding(2)
                        .background(.white)
                        .cornerRadius(10)
                    }
                    else {
                        Text("selected_photo".localized(language))
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        ZStack {
                            datas.ImageCardioPick
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 250, height: 250)
                            if datas.waiting {
                                ProgressView()
                                    .frame(width: 250, height: 250)
                            }
                        }
                        .frame(width: 250, height: 250)
                    }
                }
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
                //                }
                
                //                Spacer()
                Image(systemName: "arrowshape.up")
                    .foregroundColor(.black)
                    .padding(.top, 5)
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
                //                Spacer()
                
                VStack(spacing: 1) {
                    HStack(spacing: 1) {
                        //                    Spacer()
                        if datas.checkButton {
                            HStack {
                                Image("folder")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundColor(.black)
                                PhotosPicker("select_photo".localized(language), selection: $datas.ImageCardioItem, matching: .images)
                            }
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(15, corners: [.topLeft])
                        }
                        else {
                            Button {
                                datas.alertButton = true
                            } label: {
                                HStack {
                                    Image("folder")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .foregroundColor(.black)
                                    Text("select_photo".localized(language))
                                }
                                    .padding()
                                    .background(.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(15, corners: [.topLeft])
                            }
                            
                        }
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
                            HStack {
                                Spacer()
                                Image("magnify")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundColor(.black)
                                Text("get_result".localized(language))
                                    .fixedSize(horizontal: true, vertical: false)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding()
                            .background(datas.checkButton ? Color(.white).opacity(1.0) : Color(.white).opacity(0.3))
                            .foregroundColor(.black)
                            .cornerRadius(15, corners: [.topRight])
                            
                            
                        }
                        .disabled(!datas.checkButton)
                    }
                    
                    Button {
                        showAbout.toggle()
                    } label: {
                        //                    HStack {
                        //                        Spacer()
                        HStack {
                            Spacer()
                            Image("info")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(.black)
                            Text("about_cardio".localized(language))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding()
                        .background(Color(.white))
                    }
                    
                    Button {
                        datas.alertButton = true
                    } label: {
                        //                    HStack {
                        //                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: datas.checkButton ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                            //.fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text("terms_of_use".localized(language))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(15, corners: [.bottomRight, .bottomLeft])
                        //                        Spacer()
                        //                    }
                    }
                    //                        }
                }
                .shadow(color: Color(.black).opacity(0.3),radius: 5)
                .padding()
                
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
