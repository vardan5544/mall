//
//  MainPageModel.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 14.04.22.
//

import Foundation

//MARK: MainPage Model

struct Section {
    
    let bestExchange: [BestExchange]
    let ads: [Ads]
    let category: [Category]
    var sections: [Any] {
        return [bestExchange, ads, category]
    }
    
    init(bestExchange: [BestExchange], ads: [Ads], category: [Category]) {
        self.bestExchange = bestExchange
        self.ads = ads
        self.category = category
    }
}
