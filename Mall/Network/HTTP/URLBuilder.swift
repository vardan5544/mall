//
//  MallAPI.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import Foundation

enum URLBuilderErrors: String, Error {
    
    case invalideURL = "Invalid URL, culdn't create base"
    case invalidBody
    case invalidPath
    
    var description: String {
        return self.rawValue
    }
}

final class URLBuilder: URLBuilderProtocol {
    
    private(set) var request: URLRequest?
    private var apiProtocol: APIProtocol?
    
    init(from api: APIProtocol) {
        self.apiProtocol = api
        buildURL(from: api)
    }
    
    func buildURL(from api: APIProtocol) {
        guard var url = URL(string: api.base) else {
            assertionFailure("Invalid URL, culdn't create base from \(api.base)")
            return
        }
        url.appendPathComponent(api.path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)
        component?.queryItems = api.query.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        guard let unwrappedURL = component?.url else { return }
        var request = URLRequest(url: unwrappedURL)
        request.httpMethod = api.method.rawValue
       
        
        if let body = api.body {
            guard JSONSerialization.isValidJSONObject(body) else { return }
            request.httpBody = try? JSONSerialization.data(withJSONObject: body as [String: Any], options: .prettyPrinted)
        }
        
        if let imageUplader = api as? ImageUplaoder, let image = imageUplader.image {
            let boundary = generateBoundaryString()
            let imageData = image.jpegData(compressionQuality: 1.0)
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            guard let data = imageData else { fatalError("Something went wrong image data should not be nil.")}
//            request.httpBody = createBodyWithParameters(parameters: api.body as? [String: String] ?? [:], filePathKey: "document", imageDataKey: data, boundary: boundary) as Data
            
            request.httpBody = createBodyWithParameters(parameters: api.body as? [String: String] ?? [:], filePathKey: imageUplader.filePathKey, imageDataKey: data, boundary: boundary) as Data
        }
        
        if let multipleImageUplader = api as? MultipyImageLoad {
            let boundary = generateBoundaryString()
            let imageData = multipleImageUplader.images.compactMap({($0.key, $0.1.jpegData(compressionQuality: 1.0)!)})
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBodyWithMultipleParameters(boundary: boundary, parameters: api.body as? [String: String] ?? [:], images: imageData) as Data
        }

        
        
        if let formData = api.formData {
            let boundary = generateBoundaryString()
            if let formDataParams = formData.getParameterBoundary(boundary: boundary) {
                request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = formDataParams
            }
            
            if let formDataBlob = formData.getBlobBoundary() {
                request.httpBody?.append(formDataBlob)
            }
        }
        
        self.request = request
        
        print("method = \(api.method)")
        print("requesr URL = \(url)")
        print("headers = \(api.header)")
        print("form data = ", api.formData as Any)
        print("request body data = ", self.request?.httpBody as Any)
    }
    
    func getRequst() -> URLRequest? {
        return request
    }
    
    func rebuild() {
        guard let apiProtocol = self.apiProtocol else { return }
        buildURL(from: apiProtocol)
    }
    
    private func createBodyWithParameters(parameters: [String: String], filePathKey: String?, imageDataKey: Data, boundary: String) -> NSData {
        let body = NSMutableData();
        
       
            for (key, value) in parameters {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body
    }
    
    private func createBodyWithMultipleParameters(boundary: String, parameters: [String: String], images: [(String, Data)]) -> Data {
              
        var uploadData = Data()
        for data in images {
            uploadData.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(data.0)\"; filename=\"\(Date().timeIntervalSince1970).png\"\r\n".data(using: String.Encoding.utf8)!)
            
            uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append(data.1)
        }
        // add parameters
        for (key, value) in parameters {
            uploadData.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
        }
        uploadData.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

        return uploadData
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}


private extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: true)
        append(data!)
    }
}
