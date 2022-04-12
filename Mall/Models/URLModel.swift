//
//  URLModel.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 12.04.22.
//

import Foundation
import UIKit

struct AllUrlsGet{
    var urlForHomeAndGaren = URL(string: api + "/api/Ad/GetForHomeAndGarden")
    var urlForRealEstate = URL(string: api + "/api/Ad/GetRealEstate")
    var urlVehicle = URL(string: api + "/api/Ad/GetVehicle")
    var urlElectronics = URL(string: api + "/api/Ad/GetElectronics")
    var urlHouseOldGoods = URL(string: api + "/api/Ad/GetHouseholdGoods")
    var urlConstruction = URL(string: api + "/api/Ad/GetConstruction")
    var urlEverythingElse = URL(string: api + "/api/Ad/GetEverythingElse")
    var subAppliances = URL(string: api + "/api/Ad/GetAppliances")
    var urlForCloths = URL(string: api + "/api/Ad/GetClothesAndShoes")
    var urlForChild = URL(string: api + "/api/Ad/GetForChildren")
    var urlJewerly = URL(string: api + "/api/Ad/GetJewerlyAndAccessories")
    var urlFoodAndDrink = URL(string: api + "/api/Ad/GetProductsAndDrinks")
    var urlForCigarete = URL(string: api + "/api/Ad/GetCigaretteAndAlcohol")
    var urlForFurniture = URL(string: api + "/api/Ad/GetFurniture")
    var urlForTourismAndRest = URL(string: api + "/api/Ad/GetTourismAndRest")
    var urlForSport = URL(string: api + "/api/Ad/GetSport")
    var urlForPetsAndPlants = URL(string: api + "/api/Ad/GetPetsAndPlants")
    var urlForCulture = URL(string: api + "/api/Ad/GetCulture")
    var urlForWork = URL(string: api + "/api/Ad/GetWork")
    var urlForServices = URL(string: api + "/api/Ad/GetServices")
    var urlForHelathCare = URL(string: api + "/api/Ad/GetHealfCare")
    var urlForAcquantance = URL(string:  api + "api/Ad/GetAcquaintance")
    var urlForFaovourite =  URL(string: api + "/api/Ad/Favorite")
    var urlDeleteFavorite = URL(string: api + "/api/Ad/Favorite")
}

struct allAdUrls{
    var urlForRealEstate = URL(string: api + "/api/Ad/RealEstate")
    var urlForAppliances = URL(string: api + "/api/Ad/Appliance")
    var urlHouseOldGoods = URL(string: api + "/api/Ad/HouseholdGoods")
    var urlForCloths = URL(string: api + "/api/Ad/ClothesAndShoes")
    var urlForChild = URL(string: api + "/api/Ad/ForChildren")
    var urlJewerly = URL(string: api + "/api/Ad/JewerlyAndAccessories")
    var urlConstruction = URL(string: api + "/api/Ad/Construction")
    var urlForHomeAndGaren = URL(string: api + "/api/Ad/AllForHomeAndGarden")
    var urlElectronics = URL(string: api + "/api/Ad/Electronics")
    var urlFoodAndDrink = URL(string: api + "/api/Ad/ProductsAndDrinks")
    var urlForFurniture = URL(string: api + "/api/Ad/Furniture")
    var urlForPetsAndPlants = URL(string: api + "/api/Ad/PetsAndPlants")
    var urlForCulture = URL(string: api + "/api/Ad/Culture")
    var urlForWork = URL(string: api + "/api/Ad/Work")
    var urlForServices = URL(string: api + "/api/Ad/Services")
    var urlForAcquantance = URL(string:  api + "/api/Ad/Acquaintance")
    var urlForHelathCare = URL(string: api + "/api/Ad/HealfCare")
    var urlForSport = URL(string: api + "/api/Ad/Sport")
    var urlForTourism = URL(string: api + "/api/Ad/Tourism")
    var urlForCigarete = URL(string: api + "/api/Ad/CigaretteAndAlcohol")
    var urlEverythingElse = URL(string: api + "/api/Ad/EverythingElse")
    var urlVehicle = URL(string: api + "/api/Ad/Vehicle")
    
    var forHomeAndGarden: HomeAndGarden!
    var forRealEstate: ForRealEstate!
    var forVehicle: ForVehicle!
    var forElectronics: ForElectronics!
    var forHouseOld: House!
    var forConstruction: Construction!
    var forEverythingElse: ForEverythingElse!
    var forAppliance: SubAppliances!
    var forCloths: SubGetClothsAndShows!
    var forChild: SubGetForChildren!
    var forJewerly: SubGetJewerlyAndAccessories!
    var forFoodAndDrink: SubGetFoodAndDrink!
    var forCigareteAndAlcohol: SubSigareteAndAlcohole!
    var forFurniture: SubGetFurniture!
    var forTourismAndRest: SubTourismAndRest!
    var forSport: SubSport!
    var forPetsAndPlants: SubPetsAndPlants!
    var forCulture: SubCulture!
    var forWork: SubWork!
    var forServices: SubServices!
    var forHelathCare: SubGetHealtCare!
    var forAcquatence: SubGetAcquaintance!
}

struct RequstModel{
    var forHomeAndGarden: HomeAndGarden!
    var realEstate: ForRealEstate!
    var forVehicle: ForVehicle!
    var forElectronics: ForElectronics!
    var forHouseOld: House!
    var forConstruction: Construction!
    var forEverythingElse: ForEverythingElse!
    var forAppliance: SubAppliances!
    var forCloths: SubGetClothsAndShows!
    var forChild: SubGetForChildren!
    var forJewerly: SubGetJewerlyAndAccessories!
    var forFoodAndDrink: SubGetFoodAndDrink!
    var forCigareteAndAlcohol: SubSigareteAndAlcohole!
    var forFurniture: SubGetFurniture!
    var forTourismAndRest: SubTourismAndRest!
    var forSport: SubSport!
    var forPetsAndPlants: SubPetsAndPlants!
    var forCulture: SubCulture!
    var forWork: SubWork!
    var forServices: SubServices!
    var forHelathCare: SubGetHealtCare!
    var forAcquatence: SubGetAcquaintance!
    var forFavourite: PostFavourite!
    var deleteFav: DeleteFavorite!
}
 
struct AllUrlAd{
    var urlForRealEstate = URL(string: api + "/api/Ad/GetRealEstate")
    var urlVehicle = URL(string: api + "/api/Ad/GetVehicle")
    var urlElectronics = URL(string: api + "/api/Ad/GetElectronics")
    var urlHouseOldGoods = URL(string: api + "/api/Ad/GetHouseholdGoods")
    var urlConstruction = URL(string: api + "/api/Ad/GetConstruction")
    var urlEverythingElse = URL(string: api + "/api/Ad/GetEverythingElse")
    var urlForFaovourite =  URL(string: api + "/api/Ad/Favorite")
    var urlDeleteFavorite = URL(string: api + "/api/Ad/Favorite")
    var realEstate: ForRealEstate!
    var forVehicle: ForVehicle!
    var forElectronics: ForElectronics!
    var forHouseOld: House!
    var forConstruction: Construction!
    var forEverythingElse: ForEverythingElse!
    var forFavourite: PostFavourite!
    var deleteFav: DeleteFavorite!
}
