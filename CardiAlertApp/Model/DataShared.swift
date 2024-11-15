//
//  DataShared.swift
//  CardiAlertApp
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import PhotosUI

class DataShared: ObservableObject {
    static let shared = DataShared()
    
    @AppStorage("view") var view = "auth"
    @Published var language = "en"
    @Published var languageSheet = false
    @Published var showConnection = false
    @AppStorage("checkButton") var checkButton = false
    @AppStorage("alertButton") var alertButton = false
    
    @AppStorage("name") var name = "Shakhzod"
    @AppStorage("surname") var surname = "Botirov"
    @AppStorage("phone") var phone = "33 838 38 18"
    @Published var birthDate = Date.now
    @Published var largeImage: Image = Image("photoEx")
    @Published var showLargeImage = false
    @Published var messages: [Message] = []
    
    //MARK: EKG 9
    @Published var ImageItemECG9: PhotosPickerItem?
    @Published var ImagePickECG9: Image = Image("photoEx")
    @Published var confidenceECG9 = ""
    @Published var predicted_class_index = ""
    @Published var showResultPhotoPickECG9 = false
    @Published var waiting = false
    
    //MARK: Cardio
    @Published var ImageCardioItem: PhotosPickerItem?
    @Published var ImageCardioPick: Image = Image("photoExCardio")
    @Published var showResultCardioPhotoPick = false
    @Published var resultCardioApi = ""
}
