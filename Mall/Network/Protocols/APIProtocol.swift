//
//  APIProtocol.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import UIKit

protocol APIProtocol {
    
    var base: String { get }
    var path: String { get }
    var header: [String: Any] { get }
    var query: [String: String] { get }
    var body: [String: Any]? { get }
    var formData: MultipartFormData? { get }
    var method: RequestMethod { get }
}

protocol ImageUplaoder: APIProtocol {
    var image: UIImage? { get }
    var filePathKey:String? { get}
}

protocol MultipyImageLoad: APIProtocol {
    var images: [(key: String, UIImage)] { get }
}
