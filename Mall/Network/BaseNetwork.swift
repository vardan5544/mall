//
//  BaseNetwork.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 13.04.22.
//

import Foundation
import Alamofire

class BaseNetworkService {
    
    
    func sendPost(url: URL, body: [String: Any], complition: @escaping ([String: Any]) -> ()) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let headers: HTTPHeaders = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
       // request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
//        let task = URLSession.shared.dataTask(with: request) { data, _ ,error in
//
//            guard let data = data, error == nil else {
//                return
//            }
//            do {
//                let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//                print("Success: \(response)")
//                complition(response as! [String : Any] )
//            }
//            catch{
//                print(error, "error" )
//            }
//        }
//        task.resume()
        
        // AF Request
//
//        AF.request(url, method: .post, parameters: body, headers: headers).responseData { data in
//
//            print(data.data)
//            print(data.response)
//            print(data.value)
//
//        }
        
        
        
        
        
        
        
        
        
    }
    
    func requestGet(urlString: String, completion: @escaping (Result<([Category], BestExchange?), Error>) -> Void) {
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTc2MDk4NDYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.Dun7Td-Owx3f7VreiAVoQOliYeCQjVhVzs_t36K6hlY", "countryID": "\(1)", "culture": "am", "currency": "\(1)"]
        
        let parameters = ["Content-Type": "application/json"]
        
        AF.request(urlString, method: .get, parameters: parameters, headers: headers).responseData { snapshot in
            
            switch snapshot.result {
                
                // Success case
            case .success(let data):
                
                DispatchQueue.main.async {

                    do {
                        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

                        var categoris = [Category]()

                        if let adsWithCategories = json["adsWithCategories"] as? [[String: Any]]{
                            for items in adsWithCategories{
                                if items["category"] is [String: Any] {
                                    if let ads = items["ads"] as? [[String: Any]] {
                                        var adsArray = [Ads]()
                                        ads.forEach { dict in
                                            let adsProperty = Ads(ads: dict)
                                            adsArray.append(adsProperty)
                                        }
                                        let category = Category(categori: items, ads: adsArray)
                                        categoris.append(category)
                                    }
                                }
                            }
                        }
                        var bestExchange: BestExchange?
                        if let beastExchange = json["bestExchange"] as? [String: Any] {
                            let beastName = BestExchange(best: beastExchange)
                            bestExchange = beastName
                        }
                        
                        completion(.success((categoris, bestExchange)))

                        } catch (let jsonError) {
                            print("Failed to decode JSon", jsonError)
                            completion(.failure(jsonError))
                    }
                }
                
                // Failure case
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
