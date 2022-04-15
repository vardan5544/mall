//
//  MainPageViewModel.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 14.04.22.
//

import Foundation

class MainPageViewModel {
    
    var networkService = NetworkingService()

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


