//
//  GetApiECG.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import Alamofire
import PhotosUI
import Network

class GetApiECG: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    static let shared = GetApiECG()
    @State private var startTimer = false
    @ObservedObject var datas: DataShared = .shared
    
    func uploadImageToServer() {
        DispatchQueue.main.async { [self] in
            datas.showConnection = false
        }
        Task {
            uploadImageToServer195()
        }
    }
    
    func uploadImageToServer195() {
        let parameters = ["name": "n",
                          "id": "1"]
        guard let mediaImage = Media(withImage: compressImage(image: datas.ImagePickECG9.asUIImage()), forKey: "ECG") else { return }
        guard let url = URL(string: "http://195.158.16.43:6777/ECG") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //create boundary
        let boundary = generateBoundary()
        //set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //call createDataBody method
        let dataBody = DataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            print("data: \(String(describing: String(data: data!, encoding: .utf8)))")
            print(response)
            print(data)
            print(error)
            if let response = response {
                print(response)
                let decodedResponse = try? JSONDecoder().decode(apiPhotoECG9.self, from: data!)
                DispatchQueue.main.async { [self] in
                    self.datas.confidenceECG9 = decodedResponse?.confidence ?? ""
                    self.datas.predicted_class_index = decodedResponse?.predicted_class_index ?? ""
                    self.datas.showResultPhotoPickECG9 = true
                    self.datas.waiting = false
                }
                URLCache.shared.removeAllCachedResponses()
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print("error")
                }
            }
            self.datas.waiting = false
        }.resume()
    }
      
}

struct apiPhotoECG9: Codable {
    let confidence: String
    let predicted_class_index: String
}

func DataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
    let lineBreak = "\r\n"
    var body = Data()
    if let parameters = params {
        for (key, value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value as! String + lineBreak)")
        }
    }
    if let media = media {
        for photo in media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
    }
    body.append("--\(boundary)--\(lineBreak)")
    return body
}

func generateBoundary() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

func compressImage(image: UIImage) -> UIImage {
    let resizedImage = image.aspectFittedToHeight(200)
//        resizedImage.jpegData(compressionQuality: 0.2) // Add this line
    resizedImage.pngData()
    return resizedImage
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/png"
        self.filename = "imagefile.png"
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}

struct apiPhoto: Codable {
    let result: String
}
