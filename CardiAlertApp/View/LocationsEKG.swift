//
//  LocationsEKG.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import CoreLocation

//struct LocationsEKG: View {
//    @ObservedObject var datas: DataShared = .shared
//    @ObservedObject var locationManagerSharing = LocationManager.shared
//    private var language = LocalizationService.shared.language
//    var body: some View {
//        ZStack {
//            Image("settingsBack")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack(spacing: 16) {
//                ScrollView(.vertical, showsIndicators: false) {
//                    ForEach(datas.locationsLocal)  { results in
//                        VStack(alignment: .leading, spacing: 6.0) {
//                            HStack() {
//                                VStack(alignment: .leading) {
//                                    Text(results.name.localized(language))
//                                        .bold()
//                                        .foregroundColor(Color(.black))
//                                    
//                                    Text(results.address.localized(language))
//                                        .foregroundColor(Color(.systemGray))
//                                    
//                                    Link(results.phoneNumber, destination: URL(string: "tel://\(results.phoneNumber)")!)
//                                        .padding(10)
//                                        .foregroundColor(Color("text"))
//                                        .background(Color(hex: "ff646c"))
//                                        .cornerRadius(10)
//                                        .shadow(color: Color.black.opacity(0.3), radius: 2, y: 1)
//                                }
//                                
//                                Spacer()
//                                
//                                Button {
//                                    let url = URL(string:
//                                                    "yandexnavi://build_route_on_map?lat_to=\(results.latitude)&lon_to=\(results.longitude)")
//                                    if UIApplication.shared.canOpenURL(url!) {
//                                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
//                                    }
//                                    
//                                    else{
//                                        let urlBrowser = URL(string: "yandexmaps://maps.yandex.com/?rtext=\(CLLocationManager().location?.coordinate.latitude),\(CLLocationManager().location?.coordinate.longitude)~ \(results.latitude),\(results.longitude)&rtt=auto")
//                                        UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
//                                    }
//                                } label: {
//                                    VStack {
//                                        Image(systemName: "location.magnifyingglass")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 20)
//                                            .foregroundColor(Color(.black).opacity(0.7))
//                                        
//                                        Text("map".localized(language))
//                                            .foregroundColor(.black)
//                                        
//                                    }
//                                    .padding(15)
//                                    .background(Color(hex: "f2f2f2"))
//                                    .clipShape(Circle())
//                                    .shadow(color: Color(.black).opacity(0.3), radius: 2, y: 1)
//                                }
//                                
//                            }
//                            HStack {
//                                Text("distance_from_you".localized(language))
//                                    .foregroundColor(Color(.black))
//                                Text("\(results.distance, specifier: "%.1f")")
//                                    .foregroundColor(Color(.black))
//                                Text("km".localized(language))
//                                    .foregroundColor(Color(.black))
//                            }
//                            
//                            Button {
//                                
//                            } label: {
//                                HStack {
//                                    Spacer()
//                                    
//                                    Text("book".localized(language))
//                                        .foregroundColor(Color(.black))
//                                    
//                                    Spacer()
//                                }
//                                .frame(height: 50)
//                                .background(Color(.systemGray5))
//                                .cornerRadius(12)
//                                .padding(.top, 8)
//                            }
//                        }
//                        .padding(12)
//                        .background(.white)
//                        .cornerRadius(16)
//                        .shadow(color: Color(.black).opacity(0.2),radius: 4, y: 3)
//                        .padding(.bottom, 4)
//                        .padding(.horizontal, 4)
//                    }
//                    .padding(.top, 50)
//                }
//            }
//            .padding(.horizontal, 20)
//            
//            
//            VStack {
//                HStack {
//                    Button {
//                        withAnimation {
//                            datas.view = "ecg"
//                        }
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundStyle(Color(.white))
//                            .font(.system(size: 20))
//                    }
//                    
//                    Spacer()
//                    
//                    Text("locationsTitle".localized(language))
//                        .foregroundStyle(Color(.white))
//                        .font(.system(size: 16))
//                    
//                    Spacer()
//                    
//                    Button {
//                        
//                    } label: {
//                        Text("")
//                    }
//                }
//                .frame(height: 44)
//                .padding(.horizontal, 32)
//                .background(Color(hex: "ff646c").opacity(0.7))
//                .background(.ultraThinMaterial)
//               
//                .padding(.top, -10)
//                
//                Spacer()
//            }
//        }
//        .onAppear {
//            if locationManagerSharing.userLocation == nil { LocationManager.shared.requestLocation()
//                print("no access")
//            }
//            else {
//                self.datas.sortDataByDistance()
//            }
//        }
//        
//    }
//}

//#Preview {
//    LocationsEKG()
//}
