//
//  MallAPI.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import Foundation

final class MallError: Error {
    public var message: String
    
    init(error: NetworkError) {
        switch error {
        case .validatorError(let error):
            self.message = error
        case .responseError(let error):
            self.message = error
        case .serverError:
            self.message = "Somting went wrong!"
        case .invalidParse(let error):
            self.message = error
        }
    }
}

public enum NetworkError: Error {
    case validatorError(_ errorMessage: String)
    case responseError(_ errorMessage: String)
    case serverError
    case invalidParse(_ errorMessage: String)
}
