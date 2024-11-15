//
//  SelfCheckECGView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import PhotosUI

struct SelfCheckECGView: View {
    @ObservedObject var datas: DataShared = .shared
    @ObservedObject var PhotoUpload: GetApiECG = .shared
    @State private var waiting = false
    @State private var pickPicture = false
    @State private var PhotoPicker = false
    @State private var showAbout = false
    var language = LocalizationService.shared.language
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
                
                Spacer()
                
                VStack {
                    
                    VStack {
                        if datas.ImagePickECG9 == Image("photoEx") {
                            Text("upload_photo".localized(language))
                                .foregroundColor(Color(.black))
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                            
                            ZStack {
                                datas.ImagePickECG9
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
                                .foregroundColor(Color(.black))
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                            
                            ZStack {
                                datas.ImagePickECG9
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
                    
                    Image(systemName: "arrowshape.up")
                        .foregroundColor(Color(hex: "#ff646c"))
                        .padding(.top, 8)
                        .font(.title2)
                    
                    Text("upload_real_photo_ecg_9".localized(language))
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .padding(12)
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: Color(.black).opacity(0.3),radius: 5)
                        .padding()
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
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
                        
                        Divider()
                        
                        Button {
                            if datas.ImagePickECG9 == Image("photoEx") {
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
                                
                                Text("about_ekg_title9".localized(language))
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
                    
                }
                
                .sheet(isPresented: $showAbout) {
                    AboutEKG_9View()
                }
                
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
                
                .alert("please_select_photo".localized(language), isPresented: $pickPicture, actions: {
                    Button("ok".localized(language), role: .cancel, action: {
                        
                    })
                })
                
                .alert("result_of_photo".localized(language), isPresented: $datas.showResultPhotoPickECG9, actions: {
                    Button("ok".localized(language), role: .cancel, action: {
                        
                    })
                }, message: {
                    Text("class-\(datas.predicted_class_index)".localized(language))
                        .multilineTextAlignment(.leading)
                })
            }
            .padding(.horizontal)
            .background(Color(hex: "#F4F9FD").ignoresSafeArea())
            
            LargeImageView()
                .scaleEffect(self.datas.showLargeImage ? 1.0 : 0.0)
        }
    }
}

#Preview {
    SelfCheckECGView()
}
