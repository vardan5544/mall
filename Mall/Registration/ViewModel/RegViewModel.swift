//
//  RegViewModel.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 13.04.22.
//

import Foundation

class RegViewModel {
    
    var networkManager = BaseNetworkService()
    
    func sendPost(url: URL, body: [String: Any], complition: @escaping ([String: Any]) -> ()) {
        
        networkManager.sendPost(url: url, body: body) { data in
            
                complition(data)
        }
    }
}
