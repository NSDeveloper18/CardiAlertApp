//
//  GetApiCardio.swift
//  CardiAlertApp
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI
import Alamofire
import PhotosUI
import Network

class GetApiCardio: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    static let shared = GetApiCardio()
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
        print("uploadImageToServer")
        let parameters = ["name": "n",
                          "id": "1"]
        guard let mediaImage = Media(withImage: compressImage(image: datas.ImageCardioPick.asUIImage()), forKey: "cardi_img") else { return }
        guard let url = URL(string: "http://195.158.16.43:6788/cardiomegaliya") else { return }
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
            if let response = response {
                print(response)
                let decodedResponse = try? JSONDecoder().decode(apiCardioPhoto.self, from: data!)
                DispatchQueue.main.async { [self] in
                    self.datas.resultCardioApi = decodedResponse?.result ?? ""
                    self.datas.showResultCardioPhotoPick = true
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
            
        }.resume()
    }
    
    func uploadImageToServer192() {
        print("uploadImageToServer")
        let parameters = ["name": "n",
                          "id": "1"]
        guard let mediaImage = Media(withImage: compressImage(image: datas.ImageCardioPick.asUIImage()), forKey: "cardi_img") else { return }
        guard let url = URL(string: "http://192.168.100.12:6788/cardiomegaliya") else { return }
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
            if let response = response {
                print(response)
                let decodedResponse = try? JSONDecoder().decode(apiCardioPhoto.self, from: data!)
                DispatchQueue.main.async { [self] in
                    self.datas.resultCardioApi = decodedResponse?.result ?? ""
                    self.datas.showResultCardioPhotoPick = true
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
        }.resume()
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
    
}

struct apiCardioPhoto: Codable {
    let result: String
}
