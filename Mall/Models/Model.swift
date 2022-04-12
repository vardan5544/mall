//
//  Model.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 12.04.22.
//

import Foundation
import UIKit

//MARK: LoginModel

struct LoginModel: Encodable {
    let id: Int
    let phoneNumber, firstName, lastName, email: String
    let state, country: Int
    let sCountry: String?
    let region: Int
    let sRegion: String?
    let city: Int
    let sCity: String?
    let address: String?
    let rating: Double
    let balance: Int
    let avatar, result: String?
    
    init(login: [String:Any]) {
        self.id = login["id"] as! Int
        self.phoneNumber = login["phoneNumber"] as! String
        self.firstName = login["firstName"] as! String
        self.lastName = login["lastName"] as? String ?? ""
        self.email = login["email"] as! String
        self.state = login["state"] as! Int
        self.country = login["country"] as! Int
        self.sCountry = login["sCountry"] as? String ?? ""
        self.region = login["region"] as! Int
        self.sRegion = login["sRegion"] as? String ?? ""
        self.city = login["city"] as! Int
        self.sCity = login["sCity"] as? String ?? ""
        self.address = login["address"] as? String ?? ""
        self.rating = login["rating"] as! Double
        self.balance = login["balance"] as! Int
        self.avatar = login["avatar"] as? String ?? ""
        self.result = login["result"] as? String ?? ""
    }
}


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

// MARK: - Ad
class Ads: Decodable {
    var id, state: Int
    var name: String
    var userID, categoryID: Int
    var adDescription: String
    var image: String
    var owner: Int
    var isBestPrice: Bool
    
    init(ads: [String: Any]) {
        
        id = ads["id"]  as? Int ?? 0
        state = ads["state"] as? Int ?? 0
        name = ads["name"] as? String ?? "9090"
        userID = ads["userID"] as? Int ?? 0
        categoryID = ads["categoryID"] as? Int ?? 0
        adDescription = ads["description"] as? String ?? "0099"
        image = ads["image"] as? String ?? "imag"
        owner = ads["owner"] as? Int ?? 0
        isBestPrice = ads["isBestPrice"] as? Bool ?? true
        
        if let adsProp = ads["ads"] as? [Any]{
            if let adsWith = adsProp[0] as? [String:Any]{
                for _ in adsProp{
                    id = adsWith["id"] as! Int
                    state = adsWith["state"] as! Int
                    name = adsWith["name"] as! String
                    userID = adsWith["userID"] as! Int
                    categoryID = adsWith["categoryID"] as! Int
                    adDescription = adsWith["description"] as? String ?? "sas"
                    image = adsWith["image"] as! String
                    owner = adsWith["owner"] as! Int
                    isBestPrice = adsWith["isBestPrice"] as! Bool
                }
            }
        }
        
    }
}

// MARK: - Category
class Category: Decodable{
    var id: Int
    var name: String
    var ads: [Ads]
    
    init(categori: [String: Any], ads: [Ads]) {
        id = categori["id"] as? Int ?? 0
        name = categori["name"] as? String ?? "cat"
        self.ads = ads
        
        if let cate = categori["category"] as? [String:Any]{
            for _ in cate{
                self.id = cate["id"] as! Int
                self.name = cate["name"] as! String
                self.ads = ads
            }
        }
    }
}

// MARK: - BestExchange
class BestExchange: Decodable {
    let sale, buy: Int
    let symbol: String
    let userID, adID: Int
    let isBestPrice: Bool
    
    init(best: [String: Any]){
        sale = best["sale"] as! Int
        buy = best["buy"] as! Int
        symbol = best["symbol"] as! String
        userID = best["userID"] as! Int
        adID = best["adID"] as! Int
        isBestPrice = best["isBestPrice"] as! Bool
    }
}

//MARK: - Search
struct Name{
    var res : [GetExchange]
    init(res: [GetExchange]){
        self.res = res
    }
}

struct GetExchange: Decodable {
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let searchResultDescription, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let sourceCurrencyID, destinationCurrencyID, saleSummaRetail, buySummaRetail: Int
    let saleSumma, buySumma: Int
    
    init(res: [String:Any]) {
        self.id = res["id"] as! Int
        self.userID = res["userID"] as! Int
        self.subCategoryID = res["subCategoryID"] as! Int
        self.mainCategoryID = res["mainCategoryID"] as! Int
        self.currency = res["currency"] as! Int
        self.price = res["price"] as! Int
        self.salePercent = res["salePercent"] as! Int
        self.salePrice = res["salePrice"] as! Int
        self.countryName = res["countryName"] as! String
        self.regionName = res["regionName"] as! String
        self.cityName = res["cityName"] as! String
        self.country = res["country"] as! Int
        self.region = res["region"] as! Int
        self.city = res["city"] as! Int
        self.state = res["state"] as! Int
        self.searchResultDescription = res["searchResultDescription"] as? String ?? ""
        self.name = res["name"] as! String
        self.locationLatitude = res["locationLatitude"] as? Float ?? 0
        self.locationLongitude = res["locationLongitude"] as? Float ?? 0
        self.contact = res["contact"] as! String
        self.aim = res["aim"] as! Int
        self.owner = res["owner"] as! Int
        self.view = res["view"] as! Int
        self.tags = res["tags"] as! String
        self.isRegional = res["isRegional"] as! Bool
        self.isFavorite = res["isFavorite"] as! Bool
        self.isBestPrice = res["isBestPrice"] as! Bool
        self.imagesList = res["imagesList"] as! [String]
        self.sourceCurrencyID = res["sourceCurrencyID"] as! Int
        self.destinationCurrencyID = res["destinationCurrencyID"] as! Int
        self.saleSummaRetail = res["saleSummaRetail"] as! Int
        self.buySummaRetail = res["buySummaRetail"] as! Int
        self.saleSumma = res["saleSumma"] as! Int
        self.buySumma = res["buySumma"] as! Int
    }
}

// MARK: - GetFromHomeAndGardenElement
class HomeAndGarden{
    var homeAndGarden: [GetFromHomeAndGardenElement]
    init(homeAndGarden: [GetFromHomeAndGardenElement]){
        self.homeAndGarden = homeAndGarden
    }
}

struct GetFromHomeAndGardenElement: Decodable {
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let getFromHomeAndGardenDescription, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    
    init(homeAndGarden: [String: Any]) {
        id = homeAndGarden["id"] as! Int
        userID = homeAndGarden["userID"] as! Int
        subCategoryID = homeAndGarden["subCategoryID"] as! Int
        mainCategoryID = homeAndGarden["mainCategoryID"] as! Int
        currency = homeAndGarden["currency"] as! Int
        price = homeAndGarden["price"] as! Int
        salePercent = homeAndGarden["salePercent"] as! Int
        salePrice = homeAndGarden["salePrice"] as! Int
        countryName = homeAndGarden["countryName"] as! String
        regionName = homeAndGarden["regionName"] as! String
        cityName = homeAndGarden["cityName"] as! String
        country = homeAndGarden["country"] as! Int
        region = homeAndGarden["region"] as! Int
        city = homeAndGarden["city"] as! Int
        state = homeAndGarden["state"] as! Int
        getFromHomeAndGardenDescription = homeAndGarden["getFromHomeAndGardenDescription"] as! String
        name = homeAndGarden["name"] as! String
        locationLatitude = homeAndGarden["locationLatitude"] as? Float ?? 0
        locationLongitude = homeAndGarden["locationLongitude"] as? Float ?? 0
        contact = homeAndGarden["contact"] as! String
        aim = homeAndGarden["aim"] as! Int
        owner = homeAndGarden["owner"] as! Int
        view = homeAndGarden["view"] as! Int
        tags = homeAndGarden["tags"] as! String
        isRegional = homeAndGarden["isRegional"] as! Bool
        isFavorite = homeAndGarden["isFavorite"] as! Bool
        isBestPrice = homeAndGarden["isBestPrice"] as! Bool
        imagesList = homeAndGarden["imagesList"] as! [String]
        productState = homeAndGarden["productState"] as! Int
    }
}

class SearchGeneralPrompElement: Codable {
    let id, userID: Int
    var name: String
    let categoryID: Int
    let searchGeneralPrompDescription: String
    let owner: Int
    let image: String
    
    init(searchGeneral: [String: Any]) {
        id = searchGeneral["id"] as? Int ?? 1
        userID = searchGeneral["userID"] as? Int ?? 2
        name = searchGeneral["name"] as? String ?? "name"
        categoryID = searchGeneral["categoryID"]  as? Int ?? 3
        searchGeneralPrompDescription = searchGeneral["searchGeneralPrompDescription"] as? String ?? "searchGeneral"
        owner = searchGeneral["owner"] as? Int ?? 4
        image = searchGeneral["image"] as? String ?? "image"
    }
}

class ForRealEstate{
    var real : [RealEstate]
    init(real: [RealEstate]){
        self.real = real
    }
}

struct RealEstate: Codable {
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let space, constructionType, paymentTime, rooms: Int
    let floor: Int
    
    init(realEstate: [String:Any]) {
        id = realEstate["id"] as! Int
        userID = realEstate["userID"] as! Int
        subCategoryID = realEstate["subCategoryID"] as! Int
        mainCategoryID = realEstate["mainCategoryID"] as! Int
        currency = realEstate["currency"] as! Int
        price = realEstate["price"] as! Int
        salePercent = realEstate["salePercent"] as! Int
        salePrice = realEstate["salePrice"] as! Int
        countryName = realEstate["countryName"] as! String
        regionName = realEstate["regionName"] as! String
        cityName = realEstate["cityName"] as! String
        country = realEstate["country"] as! Int
        region = realEstate["region"] as! Int
        city = realEstate["city"] as! Int
        state = realEstate["state"] as! Int
        description = realEstate["description"] as! String
        name = realEstate["name"] as! String
        locationLatitude = realEstate["locationLatitude"] as? Float ?? 0
        locationLongitude = realEstate["locationLongitude"] as? Float ?? 0
        contact = realEstate["contact"] as! String
        aim = realEstate["aim"] as! Int
        owner = realEstate["owner"] as? Int ?? 0
        view = realEstate["view"] as! Int
        tags = realEstate["tags"] as! String
        isRegional = realEstate["isRegional"] as! Bool
        isFavorite = realEstate["isFavorite"] as! Bool
        isBestPrice = realEstate["isBestPrice"] as! Bool
        imagesList = realEstate["imagesList"] as! [String]
        space = realEstate["space"] as! Int
        constructionType = realEstate["constructionType"] as? Int ?? 0
        paymentTime = realEstate["paymentTime"] as? Int ?? 0
        rooms = realEstate["rooms"] as? Int ?? 0
        floor = realEstate["floor"] as? Int ?? 0
    }
}

class ForVehicle{
    var vehicle : [Vehicle]
    init(vheicle: [Vehicle]){
        self.vehicle = vheicle
    }
}

struct Vehicle : Codable {
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let vehicleDescription, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let mark: Int
    let sMark: String
    let model: Int
    let sModel, productionYear: String
    let customsCleared: Bool
    let mileage, engineSize, bodyType: Int
    let dEngineSize : Float
    let sBodyType: String
    let engineType: Int
    let sEngineType: String
    let driveType: Int
    let sDriveType: String
    let transmissionType: Int
    let sTransmissionType: String
    let color: Int
    let sColor: String
    let wheel: Int
    let sWheel: String
    
    init(vehicleRes: [String:Any]){
        id = vehicleRes["id"] as! Int
        userID = vehicleRes["iuserID"] as? Int ?? 0
        subCategoryID = vehicleRes["subCategoryID"] as! Int
        mainCategoryID = vehicleRes["mainCategoryID"] as! Int
        currency = vehicleRes["currency"] as! Int
        price = vehicleRes["price"] as! Int
        salePercent = vehicleRes["salePercent"] as! Int
        salePrice = vehicleRes["salePrice"] as! Int
        countryName = vehicleRes["countryName"] as! String
        regionName = vehicleRes["regionName"] as! String
        cityName = vehicleRes["cityName"] as! String
        country = vehicleRes["country"] as! Int
        region = vehicleRes["region"] as! Int
        city = vehicleRes["city"] as! Int
        state = vehicleRes["state"] as! Int
        vehicleDescription = vehicleRes["vehicleDescription"] as? String ?? ""
        name = vehicleRes["name"] as! String
        locationLatitude = vehicleRes["locationLatitude"] as? Int ?? 0
        locationLongitude = vehicleRes["locationLongitude"] as? Int ?? 0
        contact = vehicleRes["contact"] as! String
        aim = vehicleRes["aim"] as! Int
        owner = vehicleRes["owner"] as! Int
        view = vehicleRes["view"] as! Int
        tags = vehicleRes["tags"] as! String
        isRegional = vehicleRes["isRegional"] as! Bool
        isFavorite = vehicleRes["isFavorite"] as! Bool
        isBestPrice = vehicleRes["isBestPrice"] as! Bool
        imagesList = vehicleRes["imagesList"] as! [String]
        mark = vehicleRes["mark"] as? Int ?? 0
        sMark = vehicleRes["sMark"] as? String ?? ""
        model = vehicleRes["model"] as? Int ?? 0
        sModel = vehicleRes["sModel"] as? String ?? ""
        productionYear = vehicleRes["productionYear"] as? String ?? "0"
        customsCleared = vehicleRes["customsCleared"] as! Bool
        mileage = vehicleRes["mileage"] as! Int
        engineSize = vehicleRes["engineSize"] as? Int ?? 0
        dEngineSize = vehicleRes["dEngineSize"] as? Float ?? 0
        bodyType = vehicleRes["bodyType"] as? Int ?? 0
        sBodyType = vehicleRes["sBodyType"] as? String ?? "0"
        engineType = vehicleRes["engineType"] as? Int ?? 0
        sEngineType = vehicleRes["sEngineType"] as? String ?? ""
        driveType = vehicleRes["driveType"] as? Int ?? 1
        sDriveType = vehicleRes["sDriveType"] as? String ?? ""
        transmissionType = vehicleRes["transmissionType"] as? Int ?? 1
        sTransmissionType = vehicleRes["sTransmissionType"] as? String ?? ""
        color = vehicleRes["color"] as? Int ?? 0
        sColor = vehicleRes["sColor"] as? String ?? ""
        wheel = vehicleRes["wheel"] as? Int ?? 1
        sWheel = vehicleRes["sWheel"] as? String ?? ""
    }
}

class ForElectronics{
    var electronics : [Electronics]
    init(electronics: [Electronics]){
        self.electronics = electronics
    }
}


struct Electronics{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let vehicleDescription, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    
    init(elect: [String:Any]){
        id = elect["id"] as! Int
        userID = elect["userID"] as! Int
        subCategoryID = elect["subCategoryID"] as! Int
        mainCategoryID = elect["mainCategoryID"] as! Int
        currency = elect["currency"] as! Int
        price = elect["price"] as! Int
        salePercent = elect["salePercent"] as! Int
        salePrice = elect["salePrice"] as! Int
        countryName = elect["countryName"] as! String
        regionName = elect["regionName"] as! String
        cityName = elect["cityName"] as! String
        country = elect["country"] as! Int
        region = elect["region"] as! Int
        city = elect["city"] as! Int
        state = elect["state"] as! Int
        vehicleDescription = elect["description"] as! String
        name = elect["name"] as! String
        locationLatitude = elect["locationLatitude"] as? Float ?? 0
        locationLongitude = elect["locationLongitude"] as? Float ?? 0
        contact = elect["contact"] as! String
        aim = elect["aim"] as! Int
        owner = elect["owner"] as! Int
        view = elect["view"] as! Int
        tags = elect["tags"] as! String
        isRegional = elect["isRegional"] as! Bool
        isFavorite = elect["isFavorite"] as! Bool
        isBestPrice = elect["isBestPrice"] as! Bool
        imagesList = elect["imagesList"] as! [String]
        productState = elect["productState"] as! Int
    }
}

class House{
    var house: [HouseOldGoods]
    init(house: [HouseOldGoods]){
        self.house = house
    }
}

struct HouseOldGoods{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let purpleDescription, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    
    init(houseOld : [String:Any]) {
        id = houseOld["id"] as! Int
        userID = houseOld["userID"] as! Int
        subCategoryID = houseOld["subCategoryID"] as! Int
        mainCategoryID = houseOld["mainCategoryID"] as! Int
        currency = houseOld["currency"] as! Int
        price = houseOld["price"] as! Int
        salePercent = houseOld["salePercent"] as! Int
        salePrice = houseOld["salePrice"] as! Int
        countryName = houseOld["countryName"] as! String
        regionName = houseOld["regionName"] as! String
        cityName = houseOld["cityName"] as! String
        country = houseOld["country"] as! Int
        region = houseOld["region"] as! Int
        city = houseOld["city"] as! Int
        state = houseOld["state"] as! Int
        purpleDescription = houseOld["description"] as! String
        name = houseOld["name"] as! String
        locationLatitude = houseOld["locationLatitude"] as? Float ?? 0
        locationLongitude = houseOld["locationLongitude"] as? Float ?? 0
        contact = houseOld["contact"] as! String
        aim = houseOld["aim"] as! Int
        owner = houseOld["owner"] as! Int
        view = houseOld["view"] as! Int
        tags = houseOld["tags"] as! String
        isRegional = houseOld["isRegional"] as! Bool
        isFavorite = houseOld["isFavorite"] as! Bool
        isBestPrice = houseOld["isBestPrice"] as! Bool
        imagesList = houseOld["imagesList"] as! [String]
        productState = houseOld["productState"] as! Int
    }
}

class Construction{
    var const: [ForConstruction]
    init(const: [ForConstruction]){
        self.const = const
    }
}

struct ForConstruction{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let purpleDescription, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    
    init(construction : [String:Any]) {
        id = construction["id"] as! Int
        userID = construction["userID"] as! Int
        subCategoryID = construction["subCategoryID"] as! Int
        mainCategoryID = construction["mainCategoryID"] as! Int
        currency = construction["currency"] as! Int
        price = construction["price"] as! Int
        salePercent = construction["salePercent"] as! Int
        salePrice = construction["salePrice"] as! Int
        countryName = construction["countryName"] as! String
        regionName = construction["regionName"] as! String
        cityName = construction["cityName"] as! String
        country = construction["country"] as! Int
        region = construction["region"] as! Int
        city = construction["city"] as! Int
        state = construction["state"] as! Int
        purpleDescription = construction["purpleDescription"] as? String ?? ""
        name = construction["name"] as! String
        locationLatitude = construction["locationLatitude"] as? Float ?? 0
        locationLongitude = construction["locationLongitude"] as? Float ?? 0
        contact = construction["contact"] as! String
        aim = construction["aim"] as! Int
        owner = construction["owner"] as! Int
        view = construction["view"] as! Int
        tags = construction["tags"] as! String
        isRegional = construction["isRegional"] as! Bool
        isFavorite = construction["isFavorite"] as! Bool
        isBestPrice = construction["isBestPrice"] as! Bool
        imagesList = construction["imagesList"] as! [String]
        productState = construction["productState"] as! Int
    }
}

class ForEverythingElse{
    var every: [EverythingElse]
    init(every: [EverythingElse]){
        self.every = every
    }
}

struct EverythingElse{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let purpleDescription, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    
    init(everything : [String:Any]) {
        id = everything["id"] as! Int
        userID = everything["userID"] as! Int
        subCategoryID = everything["subCategoryID"] as! Int
        mainCategoryID = everything["mainCategoryID"] as! Int
        currency = everything["currency"] as! Int
        price = everything["price"] as! Int
        salePercent = everything["salePercent"] as! Int
        salePrice = everything["salePrice"] as! Int
        countryName = everything["countryName"] as! String
        regionName = everything["regionName"] as! String
        cityName = everything["cityName"] as! String
        country = everything["country"] as! Int
        region = everything["region"] as! Int
        city = everything["city"] as! Int
        state = everything["state"] as! Int
        purpleDescription = everything["purpleDescription"] as! String
        name = everything["name"] as! String
        locationLatitude = everything["locationLatitude"] as? Float ?? 0
        locationLongitude = everything["locationLongitude"] as? Float ?? 0
        contact = everything["contact"] as! String
        aim = everything["aim"] as! Int
        owner = everything["owner"] as! Int
        view = everything["view"] as! Int
        tags = everything["tags"] as! String
        isRegional = everything["isRegional"] as! Bool
        isFavorite = everything["isFavorite"] as! Bool
        isBestPrice = everything["isBestPrice"] as! Bool
        imagesList = everything["imagesList"] as! [String]
    }
}

struct MainCategories{
    var categori : [MCategori]
    init(categori: [MCategori]){
        self.categori = categori
    }
}

class MCategori: Decodable{
    let id: Int
    let category: String
    
    init(cate: [String:Any]) {
        id = cate["id"] as! Int
        category = cate["category"] as! String
    }
}

struct SubCategory{
    var subCategory: [SubCateg]
    init(subCategory: [SubCateg]){
        self.subCategory = subCategory
    }
}
class SubCateg: Decodable{
    var id:Int
    var type: String
    var baseCategoryID: Int
    
    init(sub: [String:Any]){
        id = sub["id"] as! Int
        type = sub["type"] as! String
        baseCategoryID = sub["baseCategoryID"] as! Int
    }
}

struct SubAppliances{
    var appliances: [Appliances]
    init(appliances: [Appliances]){
        self.appliances = appliances
    }
}

class Appliances{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Float
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    
    init(appliance : [String:Any]) {
        id = appliance["id"] as! Int
        userID = appliance["userID"] as! Int
        subCategoryID = appliance["subCategoryID"] as! Int
        mainCategoryID = appliance["mainCategoryID"] as! Int
        currency = appliance["currency"] as! Int
        price = appliance["price"] as! Int
        salePercent = appliance["salePercent"] as! Int
        salePrice = appliance["salePrice"] as! Int
        countryName = appliance["countryName"] as! String
        regionName = appliance["regionName"] as! String
        cityName = appliance["cityName"] as! String
        country = appliance["country"] as! Int
        region = appliance["region"] as! Int
        city = appliance["city"] as! Int
        state = appliance["state"] as! Int
        description = appliance["description"] as! String
        name = appliance["name"] as! String
        locationLatitude = appliance["locationLatitude"] as! Float
        locationLongitude = appliance["locationLongitude"] as! Float
        contact = appliance["contact"] as! String
        aim = appliance["aim"] as! Int
        owner = appliance["owner"] as! Int
        view = appliance["view"] as! Int
        tags = appliance["tags"] as! String
        isRegional = appliance["isRegional"] as! Bool
        isFavorite = appliance["isFavorite"] as! Bool
        isBestPrice = appliance["isBestPrice"] as! Bool
        imagesList = appliance["imagesList"] as! [String]
        productState = appliance["productState"] as! Int
    }
}
struct SubGetClothsAndShows{
    var clotshAndShows: [GetClothsAndShows]
    init(clotshAndShows: [GetClothsAndShows]){
        self.clotshAndShows = clotshAndShows
    }
}

class GetClothsAndShows{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    let clothingSize: String
    let shoesSize: Int
    
    init(cloths : [String:Any]) {
        id = cloths["id"] as! Int
        userID = cloths["userID"] as! Int
        subCategoryID = cloths["subCategoryID"] as! Int
        mainCategoryID = cloths["mainCategoryID"] as! Int
        currency = cloths["currency"] as! Int
        price = cloths["price"] as! Int
        salePercent = cloths["salePercent"] as! Int
        salePrice = cloths["salePrice"] as! Int
        countryName = cloths["countryName"] as! String
        regionName = cloths["regionName"] as! String
        cityName = cloths["cityName"] as! String
        country = cloths["country"] as! Int
        region = cloths["region"] as! Int
        city = cloths["city"] as! Int
        state = cloths["state"] as! Int
        description = cloths["description"] as! String
        name = cloths["name"] as! String
        locationLatitude = cloths["locationLatitude"] as! Int
        locationLongitude = cloths["locationLongitude"] as! Int
        contact = cloths["contact"] as! String
        aim = cloths["aim"] as! Int
        owner = cloths["owner"] as! Int
        view = cloths["view"] as! Int
        tags = cloths["tags"] as! String
        isRegional = cloths["isRegional"] as! Bool
        isFavorite = cloths["isFavorite"] as! Bool
        isBestPrice = cloths["isBestPrice"] as! Bool
        imagesList = cloths["imagesList"] as! [String]
        productState = cloths["productState"] as! Int
        clothingSize = cloths["clothingSize"] as! String
        shoesSize = cloths["shoesSize"] as! Int
    }
}

struct SubGetForChildren{
    var children: [GetForChildren]
    init(children: [GetForChildren]){
        self.children = children
    }
}

class GetForChildren{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    let gender: Bool
    let forNewBorns: Bool
    
    init(child : [String:Any]) {
        id = child["id"] as! Int
        userID = child["userID"] as! Int
        subCategoryID = child["subCategoryID"] as! Int
        mainCategoryID = child["mainCategoryID"] as! Int
        currency = child["currency"] as! Int
        price = child["price"] as! Int
        salePercent = child["salePercent"] as! Int
        salePrice = child["salePrice"] as! Int
        countryName = child["countryName"] as! String
        regionName = child["regionName"] as! String
        cityName = child["cityName"] as! String
        country = child["country"] as! Int
        region = child["region"] as! Int
        city = child["city"] as! Int
        state = child["state"] as! Int
        description = child["description"] as! String
        name = child["name"] as! String
        locationLatitude = child["locationLatitude"] as! Int
        locationLongitude = child["locationLongitude"] as! Int
        contact = child["contact"] as! String
        aim = child["aim"] as! Int
        owner = child["owner"] as! Int
        view = child["view"] as! Int
        tags = child["tags"] as! String
        isRegional = child["isRegional"] as! Bool
        isFavorite = child["isFavorite"] as! Bool
        isBestPrice = child["isBestPrice"] as! Bool
        imagesList = child["imagesList"] as! [String]
        productState = child["productState"] as! Int
        gender = child["clothingSize"] as! Bool
        forNewBorns = child["shoesSize"] as! Bool
    }
}

struct SubGetJewerlyAndAccessories{
    var jewerly: [JewerlyAndAccessories]
    init(jewerly: [JewerlyAndAccessories]){
        self.jewerly = jewerly
    }
}

class JewerlyAndAccessories{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    let gender: Bool
   
    init(jewAndAcces : [String:Any]) {
        id = jewAndAcces["id"] as! Int
        userID = jewAndAcces["userID"] as! Int
        subCategoryID = jewAndAcces["subCategoryID"] as! Int
        mainCategoryID = jewAndAcces["mainCategoryID"] as! Int
        currency = jewAndAcces["currency"] as! Int
        price = jewAndAcces["price"] as! Int
        salePercent = jewAndAcces["salePercent"] as! Int
        salePrice = jewAndAcces["salePrice"] as! Int
        countryName = jewAndAcces["countryName"] as! String
        regionName = jewAndAcces["regionName"] as! String
        cityName = jewAndAcces["cityName"] as! String
        country = jewAndAcces["country"] as! Int
        region = jewAndAcces["region"] as! Int
        city = jewAndAcces["city"] as! Int
        state = jewAndAcces["state"] as! Int
        description = jewAndAcces["description"] as! String
        name = jewAndAcces["name"] as! String
        locationLatitude = jewAndAcces["locationLatitude"] as! Int
        locationLongitude = jewAndAcces["locationLongitude"] as! Int
        contact = jewAndAcces["contact"] as! String
        aim = jewAndAcces["aim"] as! Int
        owner = jewAndAcces["owner"] as! Int
        view = jewAndAcces["view"] as! Int
        tags = jewAndAcces["tags"] as! String
        isRegional = jewAndAcces["isRegional"] as! Bool
        isFavorite = jewAndAcces["isFavorite"] as! Bool
        isBestPrice = jewAndAcces["isBestPrice"] as! Bool
        imagesList = jewAndAcces["imagesList"] as! [String]
        productState = jewAndAcces["productState"] as! Int
        gender = jewAndAcces["clothingSize"] as! Bool
    }
}

struct SubGetFoodAndDrink{
    var food: [FoodAndDrink]
    init(food: [FoodAndDrink]){
        self.food = food
    }
}

class FoodAndDrink{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let isLocal: Bool
    let isFrozen: Bool
    let isNaturalDrink: Bool
    
    init(foodAndDrink : [String:Any]) {
        id = foodAndDrink["id"] as! Int
        userID = foodAndDrink["userID"] as! Int
        subCategoryID = foodAndDrink["subCategoryID"] as! Int
        mainCategoryID = foodAndDrink["mainCategoryID"] as! Int
        currency = foodAndDrink["currency"] as! Int
        price = foodAndDrink["price"] as! Int
        salePercent = foodAndDrink["salePercent"] as! Int
        salePrice = foodAndDrink["salePrice"] as! Int
        countryName = foodAndDrink["countryName"] as! String
        regionName = foodAndDrink["regionName"] as! String
        cityName = foodAndDrink["cityName"] as! String
        country = foodAndDrink["country"] as! Int
        region = foodAndDrink["region"] as! Int
        city = foodAndDrink["city"] as! Int
        state = foodAndDrink["state"] as! Int
        description = foodAndDrink["description"] as! String
        name = foodAndDrink["name"] as! String
        locationLatitude = foodAndDrink["locationLatitude"] as! Int
        locationLongitude = foodAndDrink["locationLongitude"] as! Int
        contact = foodAndDrink["contact"] as! String
        aim = foodAndDrink["aim"] as! Int
        owner = foodAndDrink["owner"] as! Int
        view = foodAndDrink["view"] as! Int
        tags = foodAndDrink["tags"] as! String
        isRegional = foodAndDrink["isRegional"] as! Bool
        isFavorite = foodAndDrink["isFavorite"] as! Bool
        isBestPrice = foodAndDrink["isBestPrice"] as! Bool
        imagesList = foodAndDrink["imagesList"] as! [String]
        isLocal = foodAndDrink["isLocal"] as! Bool
        isFrozen = foodAndDrink["isFrozen"] as! Bool
        isNaturalDrink = foodAndDrink["isNaturalDrink"] as! Bool
    }
}

struct SubSigareteAndAlcohole{
    var cigarete: [CigareteAndAlcohole]
    init(cigarete: [CigareteAndAlcohole]){
        self.cigarete = cigarete
    }
}

class CigareteAndAlcohole{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
    let isLocal: Bool
    let alcoholVolume: Int
    
    init(cigarete : [String:Any]) {
        id = cigarete["id"] as! Int
        userID = cigarete["userID"] as! Int
        subCategoryID = cigarete["subCategoryID"] as! Int
        mainCategoryID = cigarete["mainCategoryID"] as! Int
        currency = cigarete["currency"] as! Int
        price = cigarete["price"] as! Int
        salePercent = cigarete["salePercent"] as! Int
        salePrice = cigarete["salePrice"] as! Int
        countryName = cigarete["countryName"] as! String
        regionName = cigarete["regionName"] as! String
        cityName = cigarete["cityName"] as! String
        country = cigarete["country"] as! Int
        region = cigarete["region"] as! Int
        city = cigarete["city"] as! Int
        state = cigarete["state"] as! Int
        description = cigarete["description"] as! String
        name = cigarete["name"] as! String
        locationLatitude = cigarete["locationLatitude"] as! Int
        locationLongitude = cigarete["locationLongitude"] as! Int
        contact = cigarete["contact"] as! String
        aim = cigarete["aim"] as! Int
        owner = cigarete["owner"] as! Int
        view = cigarete["view"] as! Int
        tags = cigarete["tags"] as! String
        isRegional = cigarete["isRegional"] as! Bool
        isFavorite = cigarete["isFavorite"] as! Bool
        isBestPrice = cigarete["isBestPrice"] as! Bool
        imagesList = cigarete["imagesList"] as! [String]
        productState = cigarete["productState"] as! Int
        isLocal = cigarete["isLocal"] as! Bool
        alcoholVolume = cigarete["alcoholVolume"] as! Int
    }
}

struct SubGetFurniture{
    var furn: [Furniture]
    init(furn: [Furniture]){
        self.furn = furn
    }
}

class Furniture{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
   
    init(furnit : [String:Any]) {
        id = furnit["id"] as! Int
        userID = furnit["userID"] as! Int
        subCategoryID = furnit["subCategoryID"] as! Int
        mainCategoryID = furnit["mainCategoryID"] as! Int
        currency = furnit["currency"] as! Int
        price = furnit["price"] as! Int
        salePercent = furnit["salePercent"] as! Int
        salePrice = furnit["salePrice"] as! Int
        countryName = furnit["countryName"] as! String
        regionName = furnit["regionName"] as! String
        cityName = furnit["cityName"] as! String
        country = furnit["country"] as! Int
        region = furnit["region"] as! Int
        city = furnit["city"] as! Int
        state = furnit["state"] as! Int
        description = furnit["description"] as! String
        name = furnit["name"] as! String
        locationLatitude = furnit["locationLatitude"] as! Int
        locationLongitude = furnit["locationLongitude"] as! Int
        contact = furnit["contact"] as! String
        aim = furnit["aim"] as! Int
        owner = furnit["owner"] as! Int
        view = furnit["view"] as! Int
        tags = furnit["tags"] as! String
        isRegional = furnit["isRegional"] as! Bool
        isFavorite = furnit["isFavorite"] as! Bool
        isBestPrice = furnit["isBestPrice"] as! Bool
        imagesList = furnit["imagesList"] as! [String]
        productState = furnit["productState"] as! Int
    }
}


struct SubTourismAndRest{
    var tourism: [TourismAndRest]
    init(tourism: [TourismAndRest]){
        self.tourism = tourism
    }
}

class TourismAndRest{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let departureDay: String
    let returnDay: String
    let reservedTickets: Int
   
    init(tourismAndRest : [String:Any]) {
        id = tourismAndRest["id"] as! Int
        userID = tourismAndRest["userID"] as! Int
        subCategoryID = tourismAndRest["subCategoryID"] as! Int
        mainCategoryID = tourismAndRest["mainCategoryID"] as! Int
        currency = tourismAndRest["currency"] as! Int
        price = tourismAndRest["price"] as! Int
        salePercent = tourismAndRest["salePercent"] as! Int
        salePrice = tourismAndRest["salePrice"] as! Int
        countryName = tourismAndRest["countryName"] as! String
        regionName = tourismAndRest["regionName"] as! String
        cityName = tourismAndRest["cityName"] as! String
        country = tourismAndRest["country"] as! Int
        region = tourismAndRest["region"] as! Int
        city = tourismAndRest["city"] as! Int
        state = tourismAndRest["state"] as! Int
        description = tourismAndRest["description"] as! String
        name = tourismAndRest["name"] as! String
        locationLatitude = tourismAndRest["locationLatitude"] as! Int
        locationLongitude = tourismAndRest["locationLongitude"] as! Int
        contact = tourismAndRest["contact"] as! String
        aim = tourismAndRest["aim"] as! Int
        owner = tourismAndRest["owner"] as! Int
        view = tourismAndRest["view"] as! Int
        tags = tourismAndRest["tags"] as! String
        isRegional = tourismAndRest["isRegional"] as! Bool
        isFavorite = tourismAndRest["isFavorite"] as! Bool
        isBestPrice = tourismAndRest["isBestPrice"] as! Bool
        imagesList = tourismAndRest["imagesList"] as! [String]
        departureDay = tourismAndRest["departureDay"] as! String
        returnDay = tourismAndRest["returnDay"] as! String
        reservedTickets = tourismAndRest["reservedTickets"] as! Int
    }
}

struct SubSport{
    var sport = [Sport]()
    init(sport: [Sport]){
        self.sport = sport
    }
}

class Sport{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
   
    init(getSport : [String:Any]) {
        id = getSport["id"] as! Int
        userID = getSport["userID"] as! Int
        subCategoryID = getSport["subCategoryID"] as! Int
        mainCategoryID = getSport["mainCategoryID"] as! Int
        currency = getSport["currency"] as! Int
        price = getSport["price"] as! Int
        salePercent = getSport["salePercent"] as! Int
        salePrice = getSport["salePrice"] as! Int
        countryName = getSport["countryName"] as! String
        regionName = getSport["regionName"] as! String
        cityName = getSport["cityName"] as! String
        country = getSport["country"] as! Int
        region = getSport["region"] as! Int
        city = getSport["city"] as! Int
        state = getSport["state"] as! Int
        description = getSport["description"] as! String
        name = getSport["name"] as! String
        locationLatitude = getSport["locationLatitude"] as! Int
        locationLongitude = getSport["locationLongitude"] as! Int
        contact = getSport["contact"] as! String
        aim = getSport["aim"] as! Int
        owner = getSport["owner"] as! Int
        view = getSport["view"] as! Int
        tags = getSport["tags"] as! String
        isRegional = getSport["isRegional"] as! Bool
        isFavorite = getSport["isFavorite"] as! Bool
        isBestPrice = getSport["isBestPrice"] as! Bool
        imagesList = getSport["imagesList"] as! [String]
        productState = getSport["productState"] as! Int
    }
}


struct SubPetsAndPlants{
    var pets = [PetsAndPlants]()
    init(pets: [PetsAndPlants]){
        self.pets = pets
    }
}

class PetsAndPlants{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
   
    init(petsAndPlants : [String:Any]) {
        id = petsAndPlants["id"] as! Int
        userID = petsAndPlants["userID"] as! Int
        subCategoryID = petsAndPlants["subCategoryID"] as! Int
        mainCategoryID = petsAndPlants["mainCategoryID"] as! Int
        currency = petsAndPlants["currency"] as! Int
        price = petsAndPlants["price"] as! Int
        salePercent = petsAndPlants["salePercent"] as! Int
        salePrice = petsAndPlants["salePrice"] as! Int
        countryName = petsAndPlants["countryName"] as! String
        regionName = petsAndPlants["regionName"] as! String
        cityName = petsAndPlants["cityName"] as! String
        country = petsAndPlants["country"] as! Int
        region = petsAndPlants["region"] as! Int
        city = petsAndPlants["city"] as! Int
        state = petsAndPlants["state"] as! Int
        description = petsAndPlants["description"] as! String
        name = petsAndPlants["name"] as! String
        locationLatitude = petsAndPlants["locationLatitude"] as! Int
        locationLongitude = petsAndPlants["locationLongitude"] as! Int
        contact = petsAndPlants["contact"] as! String
        aim = petsAndPlants["aim"] as! Int
        owner = petsAndPlants["owner"] as! Int
        view = petsAndPlants["view"] as! Int
        tags = petsAndPlants["tags"] as! String
        isRegional = petsAndPlants["isRegional"] as! Bool
        isFavorite = petsAndPlants["isFavorite"] as! Bool
        isBestPrice = petsAndPlants["isBestPrice"] as! Bool
        imagesList = petsAndPlants["imagesList"] as! [String]
        productState = petsAndPlants["productState"] as! Int
    }
}

struct SubCulture{
    var culture = [Cultre]()
    init(culture: [Cultre]){
        self.culture = culture
    }
}

class Cultre{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
   
    init(forCulture : [String:Any]) {
        id = forCulture["id"] as! Int
        userID = forCulture["userID"] as! Int
        subCategoryID = forCulture["subCategoryID"] as! Int
        mainCategoryID = forCulture["mainCategoryID"] as! Int
        currency = forCulture["currency"] as! Int
        price = forCulture["price"] as! Int
        salePercent = forCulture["salePercent"] as! Int
        salePrice = forCulture["salePrice"] as! Int
        countryName = forCulture["countryName"] as! String
        regionName = forCulture["regionName"] as! String
        cityName = forCulture["cityName"] as! String
        country = forCulture["country"] as! Int
        region = forCulture["region"] as! Int
        city = forCulture["city"] as! Int
        state = forCulture["state"] as! Int
        description = forCulture["description"] as! String
        name = forCulture["name"] as! String
        locationLatitude = forCulture["locationLatitude"] as! Int
        locationLongitude = forCulture["locationLongitude"] as! Int
        contact = forCulture["contact"] as! String
        aim = forCulture["aim"] as! Int
        owner = forCulture["owner"] as! Int
        view = forCulture["view"] as! Int
        tags = forCulture["tags"] as! String
        isRegional = forCulture["isRegional"] as! Bool
        isFavorite = forCulture["isFavorite"] as! Bool
        isBestPrice = forCulture["isBestPrice"] as! Bool
        imagesList = forCulture["imagesList"] as! [String]
        productState = forCulture["productState"] as! Int
    }
}

struct SubWork{
    var work = [Work]()
    init(work: [Work]){
        self.work = work
    }
}

class Work{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let paymentTime: Int
   
    init(forWork : [String:Any]) {
        id = forWork["id"] as! Int
        userID = forWork["userID"] as! Int
        subCategoryID = forWork["subCategoryID"] as! Int
        mainCategoryID = forWork["mainCategoryID"] as! Int
        currency = forWork["currency"] as! Int
        price = forWork["price"] as! Int
        salePercent = forWork["salePercent"] as! Int
        salePrice = forWork["salePrice"] as! Int
        countryName = forWork["countryName"] as! String
        regionName = forWork["regionName"] as! String
        cityName = forWork["cityName"] as! String
        country = forWork["country"] as! Int
        region = forWork["region"] as! Int
        city = forWork["city"] as! Int
        state = forWork["state"] as! Int
        description = forWork["description"] as! String
        name = forWork["name"] as! String
        locationLatitude = forWork["locationLatitude"] as! Int
        locationLongitude = forWork["locationLongitude"] as! Int
        contact = forWork["contact"] as! String
        aim = forWork["aim"] as! Int
        owner = forWork["owner"] as! Int
        view = forWork["view"] as! Int
        tags = forWork["tags"] as! String
        isRegional = forWork["isRegional"] as! Bool
        isFavorite = forWork["isFavorite"] as! Bool
        isBestPrice = forWork["isBestPrice"] as! Bool
        imagesList = forWork["imagesList"] as! [String]
        paymentTime = forWork["paymentTime"] as! Int
    }
}

struct SubServices{
    var service = [Services]()
    init(service: [Services]){
        self.service = service
    }
}

class Services{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let paymentTime: Int
    let transportation: Bool
    
    init(forService : [String:Any]) {
        id = forService["id"] as! Int
        userID = forService["userID"] as! Int
        subCategoryID = forService["subCategoryID"] as! Int
        mainCategoryID = forService["mainCategoryID"] as! Int
        currency = forService["currency"] as! Int
        price = forService["price"] as! Int
        salePercent = forService["salePercent"] as! Int
        salePrice = forService["salePrice"] as! Int
        countryName = forService["countryName"] as! String
        regionName = forService["regionName"] as! String
        cityName = forService["cityName"] as! String
        country = forService["country"] as! Int
        region = forService["region"] as! Int
        city = forService["city"] as! Int
        state = forService["state"] as! Int
        description = forService["description"] as! String
        name = forService["name"] as! String
        locationLatitude = forService["locationLatitude"] as! Int
        locationLongitude = forService["locationLongitude"] as! Int
        contact = forService["contact"] as! String
        aim = forService["aim"] as! Int
        owner = forService["owner"] as! Int
        view = forService["view"] as! Int
        tags = forService["tags"] as! String
        isRegional = forService["isRegional"] as! Bool
        isFavorite = forService["isFavorite"] as! Bool
        isBestPrice = forService["isBestPrice"] as! Bool
        imagesList = forService["imagesList"] as! [String]
        paymentTime = forService["paymentTime"] as! Int
        transportation = forService["transportation"] as! Bool
    }
}

struct SubGetHealtCare{
    var helath = [HelathCare]()
    init(helath: [HelathCare]){
        self.helath = helath
    }
}

class HelathCare{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let productState: Int
   
    init(healthCare : [String:Any]) {
        id = healthCare["id"] as! Int
        userID = healthCare["userID"] as! Int
        subCategoryID = healthCare["subCategoryID"] as! Int
        mainCategoryID = healthCare["mainCategoryID"] as! Int
        currency = healthCare["currency"] as! Int
        price = healthCare["price"] as! Int
        salePercent = healthCare["salePercent"] as! Int
        salePrice = healthCare["salePrice"] as! Int
        countryName = healthCare["countryName"] as! String
        regionName = healthCare["regionName"] as! String
        cityName = healthCare["cityName"] as! String
        country = healthCare["country"] as! Int
        region = healthCare["region"] as! Int
        city = healthCare["city"] as! Int
        state = healthCare["state"] as! Int
        description = healthCare["description"] as! String
        name = healthCare["name"] as! String
        locationLatitude = healthCare["locationLatitude"] as! Int
        locationLongitude = healthCare["locationLongitude"] as! Int
        contact = healthCare["contact"] as! String
        aim = healthCare["aim"] as! Int
        owner = healthCare["owner"] as! Int
        view = healthCare["view"] as! Int
        tags = healthCare["tags"] as! String
        isRegional = healthCare["isRegional"] as! Bool
        isFavorite = healthCare["isFavorite"] as! Bool
        isBestPrice = healthCare["isBestPrice"] as! Bool
        imagesList = healthCare["imagesList"] as! [String]
        productState = healthCare["productState"] as! Int
    }
}

struct SubGetAcquaintance{
    var acquaint = [Acquaintance]()
    init(acquaint: [Acquaintance]){
        self.acquaint = acquaint
    }
}

class Acquaintance{
    let id, userID, subCategoryID, mainCategoryID: Int
    let currency, price, salePercent, salePrice: Int
    let countryName, regionName, cityName: String
    let country, region, city, state: Int
    let description, name: String
    let locationLatitude, locationLongitude: Int
    let contact: String
    let aim, owner, view: Int
    let tags: String
    let isRegional, isFavorite, isBestPrice: Bool
    let imagesList: [String]
    let gender: Bool
    let acquaintanceAim: Int
    let height: Int
    let weight: Int
    let age: Int
    
    init(forAcquaint : [String:Any]) {
        id = forAcquaint["id"] as! Int
        userID = forAcquaint["userID"] as! Int
        subCategoryID = forAcquaint["subCategoryID"] as! Int
        mainCategoryID = forAcquaint["mainCategoryID"] as! Int
        currency = forAcquaint["currency"] as! Int
        price = forAcquaint["price"] as! Int
        salePercent = forAcquaint["salePercent"] as! Int
        salePrice = forAcquaint["salePrice"] as! Int
        countryName = forAcquaint["countryName"] as! String
        regionName = forAcquaint["regionName"] as! String
        cityName = forAcquaint["cityName"] as! String
        country = forAcquaint["country"] as! Int
        region = forAcquaint["region"] as! Int
        city = forAcquaint["city"] as! Int
        state = forAcquaint["state"] as! Int
        description = forAcquaint["description"] as! String
        name = forAcquaint["name"] as! String
        locationLatitude = forAcquaint["locationLatitude"] as! Int
        locationLongitude = forAcquaint["locationLongitude"] as! Int
        contact = forAcquaint["contact"] as! String
        aim = forAcquaint["aim"] as! Int
        owner = forAcquaint["owner"] as! Int
        view = forAcquaint["view"] as! Int
        tags = forAcquaint["tags"] as! String
        isRegional = forAcquaint["isRegional"] as! Bool
        isFavorite = forAcquaint["isFavorite"] as! Bool
        isBestPrice = forAcquaint["isBestPrice"] as! Bool
        imagesList = forAcquaint["imagesList"] as! [String]
        gender = forAcquaint["gender"] as! Bool
        acquaintanceAim = forAcquaint[""] as! Int
        height = forAcquaint["height"] as! Int
        weight = forAcquaint["weight"] as! Int
        age = forAcquaint["age"] as! Int
    }
}

// MARK: - AdFavourite
class AdFavourite {
    let favoriteList: [FavoriteList]
    let favAds: [FavAd]
    let favCategory: [FavCategory]
    let favResult: [FavResult]
    var addFavourite: [Any]{
        return [favoriteList,favAds,favCategory,favResult]
    }

    init(favoriteList: [FavoriteList], favResult: [FavResult], favAds: [FavAd], favCategory: [FavCategory]) {
        self.favoriteList = favoriteList
        self.favAds = favAds
        self.favCategory = favCategory
        self.favResult = favResult
    }
}

// MARK: - FavoriteList
class FavoriteList {
    let favCategory: [FavCategory]
    let favAds: [FavAd]

    init(favCategory: [FavCategory], favAds: [FavAd]) {
        self.favCategory = favCategory
        self.favAds = favAds
    }
}

// MARK: - Ad
class FavAd {
    var id, state: Int
    var name: String
    var userID, categoryID: Int
    var adDescription, image: String
    var owner: Int
    var isBestPrice: Bool

    init(favAd: [String:Any]) {
        self.id = favAd["id"] as! Int
        self.state = favAd["state"] as! Int
        self.name = favAd["name"] as! String
        self.userID = favAd["userID"] as! Int
        self.categoryID = favAd["categoryID"] as! Int
        self.adDescription = favAd["description"] as! String
        self.image = favAd["image"] as! String
        self.owner = favAd["owner"] as! Int
        self.isBestPrice = favAd["isBestPrice"] as! Bool
        
        if let adsFav = favAd["ads"] as? [Any]{
            if let adsWiths = adsFav[0] as? [String:Any]{
                for _ in adsFav{
                    id = adsWiths["id"] as! Int
                    state = adsWiths["state"] as! Int
                    name = adsWiths["name"] as! String
                    userID = adsWiths["userID"] as! Int
                    categoryID = adsWiths["categoryID"] as! Int
                    adDescription = adsWiths["description"] as? String ?? "sas"
                    image = adsWiths["image"] as! String
                    owner = adsWiths["owner"] as! Int
                    isBestPrice = adsWiths["isBestPrice"] as! Bool
                }
            }
        }
    }
}

// MARK: - Category
class FavCategory {
    var id: Int
    var name: String
    var adsFav: [FavAd]

    init(favCate: [String:Any], adsFav: [FavAd]) {
        self.id = favCate["id"] as? Int ?? 18
        self.name = favCate["name"] as? String ?? "Անշարժ գույք"
        self.adsFav = adsFav
        
        if let categ = favCate["category"] as? [String:Any]{
            for _ in categ{
                self.id = categ["id"] as! Int
                self.name = categ["name"] as! String
                self.adsFav = adsFav
            }
        }
    }
}

// MARK: - Result
class FavResult {
    let status: Int
    let message: String

    init(favRes: [String:Any]) {
        self.status = favRes["status"] as! Int
        self.message = favRes["message"] as! String
    }
}

//MARK: - POST Favourite

class PostFavourite{
    var favoriteModel = [FavoriteModel]()
    init(favor: [FavoriteModel]){
        self.favoriteModel = favor
    }
}

struct FavoriteModel{
    let status: Int
    let message: String
    
    init(favModel: [String:Any]){
        status = favModel["status"] as! Int
        message = favModel["message"] as! String
    }
}

//MARK: - Delete request
class DeleteFavorite{
    var deleteModel = [DeleteModel]()
    init(deleteModel: [DeleteModel]){
        self.deleteModel = deleteModel
    }
}

struct DeleteModel{
    let status: Int
    let message: String
    
    init(delete: [String:Any]){
        status = delete["status"] as! Int
        message = delete["message"] as! String
    }
}

class AdResult{
    var adModel = [AddAnything]()
    init(adModel: [AddAnything]){
        self.adModel = adModel
    }
}

struct AddAnything{
    let status: Int
    let massage: String
    init(add: [String:Any]){
        status = add["status"] as! Int
        massage = add["massage"] as! String
    }
}

class AddNewExchange{
    var addModel = [NewExchange]()
    init(addModel: [NewExchange]){
        self.addModel = addModel
    }
}

struct NewExchange{
    let status: Int
    let massage: String
    init(add: [String:Any]){
        status = add["status"] as! Int
        massage = add["massage"] as! String
    }
}

struct MyAdds{
    let adList: [AdList]
    let result: [AddsResult]
    let adCategory: [AdCategory]
    init(adList:[AdList], result: [AddsResult], adCategory: [AdCategory]){
        self.adList = adList
        self.result = result
        self.adCategory = adCategory
    }
}

class AdList{
    var id, state: Int
    var name: String
    var userID, categoryID: Int
    var adDescription, image: String
    var owner: Int
    var isBestPrice: Bool
    
    init(ads: [String:Any]){
        id = ads["id"]  as? Int ?? 0
        state = ads["state"] as? Int ?? 0
        name = ads["name"] as? String ?? "9090"
        userID = ads["userID"] as? Int ?? 0
        categoryID = ads["categoryID"] as? Int ?? 0
        adDescription = ads["description"] as? String ?? "0099"
        image = ads["image"] as? String ?? "imag"
        owner = ads["owner"] as? Int ?? 0
        isBestPrice = ads["isBestPrice"] as? Bool ?? true
        
        
        if let adsProp = ads["ads"] as? [Any]{
            if let adsWith = adsProp[0] as? [String:Any]{
                for _ in adsProp{
                    id = adsWith["id"] as! Int
                    state = adsWith["state"] as! Int
                    name = adsWith["name"] as! String
                    userID = adsWith["userID"] as! Int
                    categoryID = adsWith["categoryID"] as! Int
                    adDescription = adsWith["description"] as? String ?? "sas"
                    image = adsWith["image"] as! String
                    owner = adsWith["owner"] as! Int
                    isBestPrice = adsWith["isBestPrice"] as! Bool
                }
            }
        }
    }
}

class AdCategory: Decodable{
    var id: Int
    var name: String
    var ads: [Ads]
    
    init(categori: [String: Any], ads: [Ads]) {
        id = categori["id"] as? Int ?? 0
        name = categori["name"] as? String ?? "cat"
        self.ads = ads
        
        if let cate = categori["category"] as? [String:Any]{
            for _ in cate{
                self.id = cate["id"] as! Int
                self.name = cate["name"] as! String
                self.ads = ads
            }
        }
    }
}

class AddsResult {
    let status: Int
    let massage: String
   
    init(add: [String:Any]){
        status = add["status"] as! Int
        massage = add["massage"] as? String ?? ""
    }
}
