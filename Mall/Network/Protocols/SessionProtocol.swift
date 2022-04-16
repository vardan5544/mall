//
//  MallAPI.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import Foundation

protocol SessionProtocol {
    func request(with builderProtocol: URLBuilderProtocol, _ completion: @escaping (Result<Data,NetworkSessionErrors>) -> (), _ queue: DispatchQueue)
}
