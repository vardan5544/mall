//
//  MallAPI.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import Foundation

enum MallAPI: APIProtocol {
    
    case getGeneralMainPage(countryID: Int, culture: String, currency: Int)
    case getCustomLocation(longitude:Double,
                           latitude: Double)
    
    var base: String {
        switch self {
        case .getGeneralMainPage,
                .getCustomLocation:
            return MallBaseURLs.main.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getGeneralMainPage:
            return "api/General/MainPage"
        case .getCustomLocation:
            return "car/list"
        }
    }
    
    var header: [String : Any] {
        switch self {
        case let .getGeneralMainPage(countryID, culture, currency):
            return ["countryID": countryID,
                    "culture": culture,
                    "currency": currency,
                    "Content-Type": "application/json",
                    "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTc2MDk4NDYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.Dun7Td-Owx3f7VreiAVoQOliYeCQjVhVzs_t36K6hlY"]
        case .getCustomLocation:
            return ["Content-Type": "application/json"]
        default:
            return [:]
        }
    }
    
    var query: [String : String] {
        return [:]
    }
    
    var body: [String : Any]? {
        switch self {
        case .getGeneralMainPage:
            return nil
        case let .getCustomLocation(longitute, latitute):
            return [
                "longitute" : longitute,
                "latitute"  : latitute
            ]
        default:
            return nil
        }
    }
    
    var formData: MultipartFormData? {
        //        switch self {
        //        case .getToken(let username, let password):
        //            let params = [
        //                "username": username,
        //                "password": password,
        //                "grant_type": "password"
        //            ]
        //            return MultipartFormData(parameters: params, blob: nil)
        //        case .getAuthRefreshToken(let refreshToken):
        //            let params = [
        //                "grant_type": "refresh_token",
        //                "refresh_token": refreshToken
        //            ]
        //            return MultipartFormData(parameters: params, blob: nil)
        //
        //        default:
        //            return nil
        //        }
        return MultipartFormData(parameters: [:], blob: nil)
    }
    
    var method: RequestMethod {
        switch self {
            
        case .getGeneralMainPage,
                .getCustomLocation:
            return .get
            //        case .verifyAccounts:
            //            return .put
            //        case .resendCode:
            //            return .patch
            //        case .deleteDriver:
            //            return .delete
        default:
            return .post
        }
    }
}

