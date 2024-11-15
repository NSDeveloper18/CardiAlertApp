//
//  HomeView.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import CoreLocation
import Network

struct HomeView: View {
    @ObservedObject var datas: DataShared = .shared
    private let manager = CLLocationManager()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    var language = LocalizationService.shared.language
    @State private var selectedTab = "Modules"
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .font(.system(size: 29))
                    .foregroundStyle(.black)
                
                VStack(alignment: .leading) {
                    Text("\(datas.name) \(datas.surname)")
                        .font(.system(size: 17))
                        .foregroundStyle(.black)
                    
                    Text("+998 \(datas.phone)")
                        .font(.system(size: 12))
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        datas.view = "assistant"
                    }
                } label: {
                    Image(systemName: "message.badge")
                        .font(.system(size: 28))
                        .foregroundStyle(.black)
                }
                
                Button {
                    withAnimation {
                        datas.view = "settings"
                    }
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 28))
                        .foregroundStyle(.black)
                }

            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .padding()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(selectedTab.capitalized)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                TabSelector(selectedTab: $selectedTab)
                    .padding(.vertical, 16)
                
                ScrollView {
                    if selectedTab == "Modules" {
                        ModulesView()
                    } else if selectedTab == "Info" {
                        InfoView()
                    } else if selectedTab == "Location" {
                        LocationView()
                    }
                }
            }
            .padding()
            
        }
        .background(Color(hex: "#F4F9FD"))
        .onAppear()  {
            monitor.pathUpdateHandler = { [self] path in
                if path.status == .satisfied {
                    DispatchQueue.main.async { [self] in
                        datas.showConnection = false
                        print("Connection satisfied")
                    }
                }
                else {
                    DispatchQueue.main.async { [self] in
                        datas.showConnection = true
                        print("No Connection")
                    }
                }
            }
            monitor.start(queue: queue)
        }
        
    }
}

struct TabSelector: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack(spacing: 10) {
            TabButton(title: "Modules", selectedTab: $selectedTab)
            Spacer()
            TabButton(title: "Info", selectedTab: $selectedTab)
            Spacer()
            TabButton(title: "Location", selectedTab: $selectedTab)
        }
        .padding(5)
        .frame(height: 48)
        .background(Color(hex: "E6EDF5"))
        .cornerRadius(50)
    }
}

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(selectedTab == title ? .white : .black)
                .padding()
                .frame(height: 40)
                .background(selectedTab == title ? Color(hex: "#FF3F7C") : Color.gray.opacity(0.0))
                .cornerRadius(50)
        }
    }
}

// Modules View
struct ModulesView: View {
    @ObservedObject var datas: DataShared = .shared
    var body: some View {
        VStack(spacing: 10) {
            ModuleItem(icon: "ekg", title: "ECG 9", subtitle: "Electrocardiogramma", tag: "computer vision", description: "Uses ECG to diagnose eight heart diseases or determine a normal condition.")
                .onTapGesture {
                    withAnimation {
                        datas.view = "ecg"
                    }
                }
            ModuleItem(icon: "cardio", title: "Cardiomegaly", subtitle: "Electrocardiogramma", tag: "computer vision", description: "Detects the presence of cardiomegaly.")
                .onTapGesture {
                    withAnimation {
                        datas.view = "cardio"
                    }
                }
            ModuleItem(icon: "sport", title: "Sport", subtitle: "Sports cardiology", tag: "recommendations", description: "Recommends various exercises for people of all ages and health conditions.")
                .onTapGesture {
//                    withAnimation {
//                        datas.view = "ecg"
//                    }
                }
        }
    }
}

struct ModuleItem: View {
    var icon: String
    var title: String
    var subtitle: String
    var tag: String
    var description: String
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 51)
                
                Text(title)
                    .font(.system(size: 16).weight(.semibold))
                    .foregroundStyle(Color(hex: "#0A1629"))
                    
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(Color(hex: "#0A1629"))
            }
            .padding(8)
            .frame(width: 144, height: 144)
            .background(Color(hex: "#F4F9FD"))
            .cornerRadius(24)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(Color(hex: "#0A1629"))
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(8)
        .frame(height: 154)
        .background(Color.white)
        .cornerRadius(24)
    }
}

// Info View
struct InfoView: View {
    var body: some View {
        VStack(spacing: 20) {
            InfoItem(title: "about us", date: "Last modified Sep 12, 2020", color: .pink)
            InfoItem(title: "Cardiomegaly", date: "Last modified Sep 12, 2020", color: .blue)
            InfoItem(title: "Cardiomegaly", date: "Last modified Sep 12, 2020", color: .yellow)
        }
    }
}

struct InfoItem: View {
    var title: String
    var date: String
    var color: Color
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 4)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(.gray)
        }
        .padding(.vertical)
        .padding(.trailing)
        .background(Color.white)
        .cornerRadius(10)
    }
}

// Location View
struct LocationView: View {
    var body: some View {
        VStack(spacing: 20) {
            LocationItem(imageName: "building1", title: "Republican Specialized Scientific and Practical Center of Cardiology", address: "Mirzo-Ulugbek district, Osiyo str, 4", timings: "Monday 08:00 - 15:00\nTuesday 08:00 - 15:00\nWednesday 08:00 - 15:00\nThursday 08:00 - 15:00\nFriday 08:00 - 15:00\nSaturday 08:00 - 15:00\nSunday 08:00 - 15:00", phone: "+998 71 237 38 44")
            LocationItem(imageName: "building2", title: "HAYAT MEDICAL CENTRE", address: "Gulnara str., 51/4, Yunusabad district, Tashkent", timings: "Monday 08:00 - 19:00\nTuesday 08:00 - 19:00\nWednesday 08:00 - 19:00\nThursday 08:00 - 19:00\nFriday 08:00 - 19:00\nSaturday 08:00 - 19:00\nSunday 10:00 - 17:00", phone: "+998 71 237 38 44")
        }
    }
}

struct LocationItem: View {
    var imageName: String
    var title: String
    var address: String
    var timings: String
    var phone: String
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 7) {
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 114, height: 59)
                    .cornerRadius(7)
                
                Text(address)
                    .font(.system(size: 10))
                    .foregroundStyle(Color(hex: "#0A1629"))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding()
            .frame(width: 144, height: 144)
            .background(Color(hex: "#F4F9FD"))
            .cornerRadius(24)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: "#0A1629"))
                
                
                Text(timings)
                    .font(.system(size: 8))
                    .foregroundStyle(Color(hex: "#0A1629"))
                
                Text(phone)
                    .font(.system(size: 10))
                    .foregroundStyle(Color(hex: "#FFFFFF"))
                    .padding(6)
                    .background(.green)
                    .cornerRadius(5)
            }
            Spacer()
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(24)
    }
}

#Preview {
    HomeView()
}

/*
 struct HomeView: View {
     @ObservedObject var datas: DataShared = .shared
     @State private var currentIndex = 1
     @State private var tappedIndex: Int? = nil
     @State var testViewTap = false
     @State var onCoding = false
     private let manager = CLLocationManager()
     let monitor = NWPathMonitor()
     let queue = DispatchQueue(label: "Monitor")
     private var language = LocalizationService.shared.language
     var body: some View {
         let items = [
             Item(img: "cvdIcon", txt: "CVD AI", view: "cvd"),
             Item(img: "ecgIcon", txt: "ECG-AI", view: "ecg"),
 //            Item(img: "exoIcon", txt: "EXO Cardio", view: "exo"),
 //            Item(img: "cardioIcon", txt: "CardioMegalia", view: "cardio"),
             Item(img: "settings", txt: "settings", view: "settings"),
         ]
         ZStack {
             Image("settingsBack")
                 .resizable()
                 .scaledToFill()
                 .edgesIgnoringSafeArea(.all)
             
             VStack {
                 HStack {
                     Image(systemName: "person.circle")
                         .font(.system(size: 29))
                         .foregroundStyle(.black)
                     
                     VStack(alignment: .leading) {
                         Text("\(datas.name) \(datas.surname)")
                             .font(.system(size: 17))
                             .foregroundStyle(.black)
                         
                         Text("+998 \(datas.phone)")
                             .font(.system(size: 12))
                             .foregroundStyle(.black)
                     }
                     
                     Spacer()
                     
                     Button {
                         withAnimation {
                             datas.view = "settings"
                         }
                     } label: {
                         Image(systemName: "gear")
                             .font(.system(size: 28))
                             .foregroundStyle(.black)
                     }

                 }
                 .padding()
                 .background(.white)
                 .cornerRadius(10)
                 .padding(30)
                 
                 Spacer()
                 
                 Text("this_is_test".localized(language))
                     .multilineTextAlignment(.center)
                     .foregroundColor(Color(hex: "880808"))
                     .fontWeight(.semibold)
                     .padding(.horizontal)
                     .offset(y: 20)
                 
                 Spacer()
                 
                 CardStack(items, currentIndex: $currentIndex) { namedItems in
                     Button {
                         withAnimation {
                             datas.view = namedItems.view
                         }
                     } label: {
                         ZStack {
                             RoundedRectangle(cornerRadius: 20)
                                 .fill(Color(hex: "#ff646c"))
                                 .frame(width: 300, height: 260)
                                 .shadow(color: Color.black.opacity(0.6), radius: 5)
                             
                             VStack {
                                 Spacer()
                                 
                                 Image("\(namedItems.img)")
                                     .resizable()
                                     .scaledToFit()
                                     .frame(height: 180)
                                 
                                 Spacer()
                                 
                                 Text(namedItems.txt.localized(language))
                                     .font(.title2)
                                     .fontWeight(.bold)
                                     .foregroundColor(.white)
                                     .padding(.bottom, 10)
                             }
                         }
                     }
                     .buttonStyle(MyButtonStyle())
                 }
                 .frame(height: 220)
                 Spacer()
                     .alert("check_internet_connection".localized(language), isPresented: $datas.showConnection) {
                         Button("ok".localized(language), role: .cancel, action: {   })
                     }
             }
             
         }
         .onAppear()  {
             monitor.pathUpdateHandler = { [self] path in
                 if path.status == .satisfied {
                     DispatchQueue.main.async { [self] in
                         datas.showConnection = false
                         print("Connection satisfied")
                     }
                 }
                 else {
                     DispatchQueue.main.async { [self] in
                         datas.showConnection = true
                         print("No Connection")
                     }
                 }
             }
             monitor.start(queue: queue)
         }
         
     }
 }

 */
