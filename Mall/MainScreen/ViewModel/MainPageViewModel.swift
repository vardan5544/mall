//
//  MainPageViewModel.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 14.04.22.
//

import Foundation

class MainPageViewModel {
    
    var networkService = NetworkingService()

//    func getGeneralMainPage(_ countryID: Int = 1,_ culture: String = "am", currency: Int = 1, completion: @escaping (Result<([Category], BestExchange?), Error>) -> Void) {
//
//        SessionNetwork.init().request(with: URLBuilder.init(from: MallAPI.getGeneralMainPage(countryID: countryID, culture: culture, currency: currency))) { result in
//
//            switch result {
//                case .success(let data):
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
//
//                    var categoris = [Category]()
//
//                    if let adsWithCategories = json["adsWithCategories"] as? [[String: Any]]{
//                        for items in adsWithCategories{
//                            if let category = items["category"] as? [String: Any] {
//                                if let ads = items["ads"] as? [[String: Any]] {
//                                    var adsArray = [Ads]()
//                                    ads.forEach { dict in
//                                        var adsProperty = Ads(ads: dict)
//                                        adsArray.append(adsProperty)
//                                    }
//                                    let category = Category(categori: items, ads: adsArray)
//                                    categoris.append(category)
//                                }
//                            }
//                        }
//                    }
//                    var bestExchange: BestExchange?
//                    if let beastExchange = json["bestExchange"] as? [String: Any] {
//                        let beastName = BestExchange(best: beastExchange)
//                        bestExchange = beastName
//                    }
//
//                    completion(.success((categoris, bestExchange)))
//
//                    } catch let jsonError {
//                        print("Failed to decode JSon", jsonError)
//                        completion(.failure(jsonError))
//                }
//
//
//            case .failure(let error):
//                print("some error")
//                completion(.failure(error))
//                return
//
//            }
//        }
//    }
    
    func fetchRequest(urlString: String, callBack: @escaping (Result<([Category], BestExchange?), Error>) -> Void) {
        
        networkService.requestGet(urlString: urlString) { (result) in

            switch result {
            case .success(let data):
                callBack(.success(data))
                
            case .failure(let error):
                callBack(.failure(error))
            }
        }
    }
}


