//
//  File.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 14.04.22.
//

import UIKit

// Network Service

class NetworkingService {

    func loginPostRequest(url: URL,body: [String: Any], completion: @escaping (Result<LoginModel?, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTg2NTE0MTYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.aOjU3Ap8g793c0Wzze0XPikT1-c_Hzpw9wKIViZYmZY"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)

                    var loginNames: LoginModel?

                    if let items = json as? [String: Any] {
                        let name = LoginModel(login: items)
                        loginNames = name
                    }
                    completion(.success(loginNames))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }


    func requestGet(urlString: String, completion: @escaping (Result<([Category], BestExchange?), Error>) -> Void){

        guard let url = URL(string: urlString) else {return}

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTc2MDk4NDYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.Dun7Td-Owx3f7VreiAVoQOliYeCQjVhVzs_t36K6hlY"]

        request.headers = ["countryID": "\(1)", "culture": "am", "currency": "\(1)"]

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                if let error = error{
                    print("some error")
                    completion(.failure(error))
                    return
                }

                do {
                    guard let data = data else {return}
                    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

                    var categoris = [Category]()

                    if let adsWithCategories = json["adsWithCategories"] as? [[String: Any]]{
                        for items in adsWithCategories{
                            if let category = items["category"] as? [String: Any] {
                                if let ads = items["ads"] as? [[String: Any]] {
                                    var adsArray = [Ads]()
                                    ads.forEach { dict in
                                        var adsProperty = Ads(ads: dict)
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

                    }catch let jsonError {
                        print("Failed to decode JSon", jsonError)
                        completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    func sendPost(url: URL, body: [String: Any], complition: @escaping ([String: Any]) -> ()) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, _ ,error in

            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                print("Success: \(response)")
                complition(response as! [String : Any] )
            }
            catch{
                print(error, "error" )
            }
        }
        task.resume()
    }

    func postRequset(url: URL,body: [String: Any],completion: @escaping (Result<Name, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)

                    var names = [GetExchange]()

                    if let products = json as? [[String: Any]] {

                        for product in products {
                            let prop = GetExchange(res: product)
                            names.append(prop)
                        }
                    }
                    let price = Name(res: names)
                    completion(.success(price))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postRequsetForHomeAndGarden(url: URL,body: [String: Any],completion: @escaping (Result<HomeAndGarden, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)

                    var forHome = [GetFromHomeAndGardenElement]()

                    if let products = json as? [[String: Any]] {

                        for product in products {
                            let prop = GetFromHomeAndGardenElement(homeAndGarden: product)
                            forHome.append(prop)
                        }
                    }

                   let forHomeAndGarden = HomeAndGarden(homeAndGarden: forHome)
                    completion(.success(forHomeAndGarden))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func searchPropmt(url: URL,body: [String: Any],completion: @escaping (Result<SearchGeneralPrompElement, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in

//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode
//
//            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)

//                    var searchResult = [SearchGeneralPrompElement]()
                    var searchResult: SearchGeneralPrompElement?

                    if let products = json as? [String: Any] {
                        let searchName = SearchGeneralPrompElement(searchGeneral: products)
                        searchResult = searchName
                    }
                    completion(.success(searchResult!))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
//        }
        task.resume()
    }
//
    func postRealEstate(url: URL,body: [String: Any],completion: @escaping (Result<ForRealEstate, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var realEstate = [RealEstate]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = RealEstate(realEstate: product)
                            realEstate.append(prop)
                        }
                    }
                   let real = ForRealEstate(real: realEstate)
                    completion(.success(real))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postVehicle(url: URL,body: [String: Any],completion: @escaping (Result<ForVehicle, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var vehicle = [Vehicle]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Vehicle(vehicleRes: product)
                            vehicle.append(prop)
                        }
                    }
                    let veh = ForVehicle(vheicle: vehicle)
                    completion(.success(veh))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postElectronics(url: URL,body: [String: Any],completion: @escaping (Result<ForElectronics, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var elect = [Electronics]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Electronics(elect: product)
                            elect.append(prop)
                        }
                    }
                    let electronic = ForElectronics(electronics: elect)
                    completion(.success(electronic))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postHouseOldGoods(url: URL,body: [String: Any],completion: @escaping (Result<House, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var houseOldGoods = [HouseOldGoods]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = HouseOldGoods(houseOld: product)
                            houseOldGoods.append(prop)
                        }
                    }
                    let houseOld = House(house: houseOldGoods)
                    completion(.success(houseOld))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postConstruction(url: URL,body: [String: Any],completion: @escaping (Result<Construction, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var const = [ForConstruction]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = ForConstruction(construction: product)
                            const.append(prop)
                        }
                    }

                    let construct = Construction(const: const)
                    completion(.success(construct))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postEverything(url: URL,body: [String: Any],completion: @escaping (Result<ForEverythingElse, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var every = [EverythingElse]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = EverythingElse(everything: product)
                            every.append(prop)
                        }
                    }
                    let everyElse = ForEverythingElse(every: every)
                    completion(.success(everyElse))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func requestGetMainCategori(urlString: String, completion: @escaping (Result<MainCategories, Error>) -> Void){

        guard let url = URL(string: urlString) else {return}

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTc2MDk4NDYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.Dun7Td-Owx3f7VreiAVoQOliYeCQjVhVzs_t36K6hlY"]

        request.headers = ["culture": "am"]

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                if let error = error{
                    print("some error")
                    completion(.failure(error))
                    return
                }
                do {
                    guard let data = data else {return}
                    let json = try JSONSerialization.jsonObject(with: data,options: .allowFragments)

                    var category = [MCategori]()
                    if let cate = json as? [[String:Any]] {
                        for product in cate{
                            let cateName = MCategori(cate: product)
                            category.append(cateName)
                        }
                    }
                    let mainCat = MainCategories(categori: category)
                    completion(.success(mainCat))
                }catch let jsonError {
                    print("Failed to decode JSon", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    func postSubCategories(url: URL,body: [String: Any],completion: @escaping (Result<SubCategory, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var sub = [SubCateg]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = SubCateg(sub: product)
                            sub.append(prop)
                        }
                    }
                    let subCate = SubCategory(subCategory: sub)
                    completion(.success(subCate))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }


    func postSubAppliances(url: URL,body: [String: Any],completion: @escaping (Result<SubAppliances, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var applicent = [Appliances]()
                    var clothsAndShows = [GetClothsAndShows]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Appliances(appliance: product)
                            applicent.append(prop)
                        }
                    }
                    let subAppliances = SubAppliances(appliances: applicent)
                    completion(.success(subAppliances))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postSubGetClothsAnd(url: URL,body: [String: Any],completion: @escaping (Result<SubGetClothsAndShows, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var clothsAndShows = [GetClothsAndShows]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = GetClothsAndShows(cloths: product)
                            clothsAndShows.append(prop)
                        }
                    }
                    let subCloths = SubGetClothsAndShows(clotshAndShows: clothsAndShows)
                    completion(.success(subCloths))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postGetForChildren(url: URL,body: [String: Any],completion: @escaping (Result<SubGetForChildren, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var childrens = [GetForChildren]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = GetForChildren(child: product)
                            childrens.append(prop)
                        }
                    }
                    let child = SubGetForChildren(children: childrens)
                    completion(.success(child))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postJewelryAndAcces(url: URL,body: [String: Any],completion: @escaping (Result<SubGetJewerlyAndAccessories, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var jewerly = [JewerlyAndAccessories]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = JewerlyAndAccessories(jewAndAcces: product)
                            jewerly.append(prop)
                        }
                    }
                    let jew = SubGetJewerlyAndAccessories(jewerly: jewerly)
                    completion(.success(jew))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postRequsetFoodAndDrink(url: URL,body: [String: Any],completion: @escaping (Result<SubGetFoodAndDrink, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var food = [FoodAndDrink]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = FoodAndDrink(foodAndDrink: product)
                            food.append(prop)
                        }
                    }
                   let foodAndDrink = SubGetFoodAndDrink(food: food)
                    completion(.success(foodAndDrink))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postRequsetCigareteAndDrink(url: URL,body: [String: Any],completion: @escaping (Result<SubSigareteAndAlcohole, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var cigarete = [CigareteAndAlcohole]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = CigareteAndAlcohole(cigarete: product)
                            cigarete.append(prop)
                        }
                    }
                   let cigareteAndAlcohole = SubSigareteAndAlcohole(cigarete: cigarete)
                    completion(.success(cigareteAndAlcohole))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postRequsetFurniture(url: URL,body: [String: Any],completion: @escaping (Result<SubGetFurniture, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var furn = [Furniture]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Furniture(furnit: product)
                            furn.append(prop)
                        }
                    }
                   let getFurniture = SubGetFurniture(furn: furn)
                    completion(.success(getFurniture))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postRequsetTourismAndRest(url: URL,body: [String: Any],completion: @escaping (Result<SubTourismAndRest, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var tourism = [TourismAndRest]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = TourismAndRest(tourismAndRest: product)
                            tourism.append(prop)
                        }
                    }
                   let tourismAndRest = SubTourismAndRest(tourism: tourism)
                    completion(.success(tourismAndRest))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postGetSport(url: URL,body: [String: Any],completion: @escaping (Result<SubSport, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var sport = [Sport]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Sport(getSport: product)
                            sport.append(prop)
                        }
                    }
                   let getSport = SubSport(sport: sport)
                    completion(.success(getSport))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postPetsAndPlants(url: URL,body: [String: Any],completion: @escaping (Result<SubPetsAndPlants, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var pets = [PetsAndPlants]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = PetsAndPlants(petsAndPlants: product)
                            pets.append(prop)
                        }
                    }
                   let petsAndPlants = SubPetsAndPlants(pets: pets)
                    completion(.success(petsAndPlants))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postCulture(url: URL,body: [String: Any],completion: @escaping (Result<SubCulture, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var culture = [Cultre]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Cultre(forCulture: product)
                            culture.append(prop)
                        }
                    }
                   let forCulture = SubCulture(culture: culture)
                    completion(.success(forCulture))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postWork(url: URL,body: [String: Any],completion: @escaping (Result<SubWork, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var work = [Work]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Work(forWork: product)
                            work.append(prop)
                        }
                    }
                   let forWork = SubWork(work: work)
                    completion(.success(forWork))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postServices(url: URL,body: [String: Any],completion: @escaping (Result<SubServices, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var service = [Services]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Services(forService: product)
                            service.append(prop)
                        }
                    }
                   let forService = SubServices(service: service)
                    completion(.success(forService))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postGetHelathCare(url: URL,body: [String: Any],completion: @escaping (Result<SubGetHealtCare, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var health = [HelathCare]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = HelathCare(healthCare: product)
                            health.append(prop)
                        }
                    }
                   let helathCare = SubGetHealtCare(helath: health)
                    completion(.success(helathCare))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func postGetAcquaintance(url: URL,body: [String: Any],completion: @escaping (Result<SubGetAcquaintance, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var acquaint = [Acquaintance]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = Acquaintance(forAcquaint: product)
                            acquaint.append(prop)
                        }
                    }
                   let forAcquaint = SubGetAcquaintance(acquaint: acquaint)
                    completion(.success(forAcquaint))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func requestGetFavourite(urlString: String, completion: @escaping (Result<([FavCategory],FavResult?), Error>) -> Void){

        guard let url = URL(string: urlString) else {return}

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]

        request.headers = ["userID": "\(100009)","culture": "am"]


        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                if let error = error{
                    print("some error")
                    completion(.failure(error))
                    return
                }
                do {
                    guard let data = data else {return}
                    let json = try JSONSerialization.jsonObject(with: data,options: .allowFragments) as! [String:Any]

                    var favCate = [FavCategory]()

                    if let favoriteList = json["favoriteList"] as? [[String:Any]] {
                        for items in favoriteList{
                            if let categ = items["category"] as? [String:Any] {
                                if let ads = items["ads"] as? [[String:Any]]{
                                    var arrayAds = [FavAd]()
                                    ads.forEach {dict in
                                        var adProp = FavAd(favAd: dict)
                                        arrayAds.append(adProp)
                                    }
                                    let cate = FavCategory(favCate: items, adsFav: arrayAds)
                                    favCate.append(cate)
                                }

                            }
                        }
                    }

                    var favRes: FavResult?
                    if let favResult = json["result"] as? [String:Any]{
                        let favName = FavResult(favRes: favResult)
                        favRes = favName
                    }

                    completion(.success((favCate,favRes)))

                }catch let jsonError {
                    print("Failed to decode JSon", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    func requestPostFavourite(url: URL,body: [String: Any],completion: @escaping (Result<PostFavourite, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)

                    var favModel = [FavoriteModel]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = FavoriteModel(favModel: product)
                            favModel.append(prop)
                        }
                    }
                   let favorite = PostFavourite(favor: favModel)
                    completion(.success(favorite))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func deleteFavorite(url: URL,completion: @escaping (Result<DeleteFavorite, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]

        request.headers = ["userID": "\(100009)", "adID" : "\(28)"]



        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    var del = [DeleteModel]()
                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = DeleteModel(delete: product)
                            del.append(prop)
                        }
                    }
                   let delete = DeleteFavorite(deleteModel: del)
                    completion(.success(delete))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func addExchange(url: URL,body: [String: Any],completion: @escaping (Result<AddNewExchange, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTYwMTEyMjUsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.RNfizbze-UN8goUiBgFxZfMm7D5QkMZk5KmtdROoa4U"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [self]
            (data, response, error) -> Void in

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode

            if (statusCode == 200) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)

                    var adModel = [NewExchange]()

                    if let products = json as? [[String: Any]] {
                        for product in products {
                            let prop = NewExchange(add: product)
                            adModel.append(prop)
                        }
                    }
                   let add = AddNewExchange(addModel: adModel)
                    completion(.success(add))
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }


    func getMyAdds(urlString: String, completion: @escaping (Result<([AdCategory], AddsResult?), Error>) -> Void){

        guard let url = URL(string: urlString) else {return}

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTc2MDk4NDYsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.Dun7Td-Owx3f7VreiAVoQOliYeCQjVhVzs_t36K6hlY"]

        request.headers = ["userID": "\(1)", "culture": "am"]

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                if let error = error{
                    print("some error")
                    completion(.failure(error))
                    return
                }

                do {
                    guard let data = data else {return}
                    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

                    var categoris = [AdCategory]()

                    if let adsWithCategories = json["adsWithCategories"] as? [[String: Any]]{
                        for items in adsWithCategories{
                            if let category = items["category"] as? [String: Any] {
                                if let ads = items["ads"] as? [[String: Any]] {
                                    var adsArray = [Ads]()
                                    ads.forEach { dict in
                                        var adsProperty = Ads(ads: dict)
                                        adsArray.append(adsProperty)
                                    }
                                    let category = AdCategory(categori: items, ads: adsArray)
                                    categoris.append(category)
                                }
                            }
                        }
                    }

                    var adResult: AddsResult?
                    if let adRes = json["result"] as? [String:Any]{
                        let res = AddsResult(add: adRes)
                        adResult = res
                    }

                    completion(.success((categoris,adResult)))

                    }catch let jsonError {
                        print("Failed to decode JSon", jsonError)
                        completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}



