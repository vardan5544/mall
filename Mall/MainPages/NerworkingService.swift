//
//  NerworkingService.swift
//  Mall
//
//  Created by Dmitry Mkrtumov on 15.04.22.
//

import UIKit

class NetworkingService {
    
    func loginPostRequest(url: URL,body: [String: Any], completion: @escaping (Result<LoginModel?, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTg2NTE0MTYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.aOjU3Ap8g793c0Wzze0XPikT1-c_Hzpw9wKIViZYmZY"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                    var loginNames: LoginModel?
                    
                    if let items = json as? [String: Any] {
                        let name = LoginModel(login: items)
                        loginNames = name
                    }
                    completion(.success(loginNames))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }
}// Class NetworkingService
