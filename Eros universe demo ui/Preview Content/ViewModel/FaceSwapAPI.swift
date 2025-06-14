
import Foundation
import UIKit


func performFaceSwap(
    sourceImage: UIImage,
    targetImage: UIImage,
    completion: @escaping (UIImage?) -> Void
) {
    let url = URL(string: "http://192.168.1.7:8000/face-swap")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    var body = Data()

    // Source Image
    if let imageData = sourceImage.jpegData(compressionQuality: 0.9) {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"source\"; filename=\"source.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
    }

    // Target Image
    if let imageData = targetImage.jpegData(compressionQuality: 0.9) {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"target\"; filename=\"target.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
    }

    // End of Body
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    request.httpBody = body

    // ✅ Debug: Log outgoing request
       print("🛰️ Sending POST request to: \(url)")
       print("📦 Body size: \(body.count) bytes")
    
    // Make the request
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error: \(error?.localizedDescription ?? "unknown")")
            completion(nil)
            return
        }

        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            print("Failed to decode image")
            completion(nil)
        }
    }.resume()
}
