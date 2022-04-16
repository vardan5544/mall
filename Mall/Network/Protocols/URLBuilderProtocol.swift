//
//  MallAPI.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import Foundation

protocol URLBuilderProtocol {
    
    var request: URLRequest? { get }
   
    init(from api: APIProtocol)
    
    func buildURL(from api: APIProtocol)
    func getRequst() -> URLRequest?
    func rebuild()
}
