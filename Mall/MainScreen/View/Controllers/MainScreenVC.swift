//
//  ViewController.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 12.04.22.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class MainScreenVC: UIViewController, TableViewCellDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var buyLbl: UILabel!
    @IBOutlet weak var buyPriceLbl: UILabel!
    @IBOutlet weak var sailLbl: UILabel!
    @IBOutlet weak var sailPriceLbl: UILabel!
        
    var model = MainPageViewModel()
    var sectionModel = [Section]()
    
    //var searchPropm: SearchGeneralPrompElement!
    var resultArray: [String] = [String]()
    
    var searchItems : [Ads] = [Ads]()
    var collectionImage: MainPageTableViewCell?// TODO: - stexcel
    
    var categoris: [Category]?
    var bestExchange: BestExchange?
    var searching = false

    let searchUrl = URL(string: api + "/api/General/Prompt")
    let urlString = api + "/api/General/MainPage"

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
        setupTopView()
    }
    
    // MARK: - Get Data
  
    func getData() {
        
        model.fetchRequest(urlString: urlString) { [weak self] result in

            guard let self = self else { return }

            switch result {
            case .success(let response):
                
                self.categoris = response.0
                self.bestExchange = response.1
                self.categoris?.removeLast()
                self.buyPriceLbl.text = "\(self.bestExchange!.buy)$"
                self.sailPriceLbl.text = "\(self.bestExchange!.sale)$"
                self.mainTableView.reloadData()

            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    // MARK: - Setup Top View
    
    private func setupTopView() {
        
        topView.layer.cornerRadius = 10
        topView.layer.borderWidth = 1
        topView.layer.borderColor = #colorLiteral(red: 0.7059701085, green: 0.7637518048, blue: 0.8472303748, alpha: 1).cgColor
    }
    
    // MARK: - Setup Table View
    
    private func setupTableView() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension MainScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoris?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPageTableViewCell") as! MainPageTableViewCell
        
        if searching {
       
            cell.mainCollectionView.tag = indexPath.section
            cell.configure(section : categoris![indexPath.row], searching: true, res: searchItems)
        }else {
            
            guard let categoris = categoris else { return UITableViewCell() }
            
            cell.mainCollectionView.tag = indexPath.section
            cell.configure(section: categoris[indexPath.row], searching: false, res: categoris[indexPath.row].ads)
            cell.sectionText.text = cell.sectionModel?.name
            cell.delegate = self
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //MARK: Amen cell-i selectic ira ejy gna (indexov)
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainPageTableViewCell") as! MainPageTableViewCell
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       // let vc = storyBoard.instantiateViewController(withIdentifier: "realEstate") as! RealEstateVC
        let index = indexPath.row
        //vc.indexForRequest = index
        //vc.indexOfTableViewCell = indexPath.row
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func selectCell(cell: MainPageTableViewCell, indexPath: IndexPath) {
//        if let tableIndexPath = mainTableView.indexPath(for: cell){
//            let item = categoris![tableIndexPath.row].ads[indexPath.row]
//           // let st = UIStoryboard(name: "AdsDetail", bundle: nil)
//           // let vc = st.instantiateViewController(withIdentifier: "AdsDetailVC") as! AdsDetailVC
//            //self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    // MARK: - Open Ad detail page
    
    func getSelectedAd(ad: Ads, category: Category?) {
        
        let vc = UIStoryboard(name: "AdsDetail", bundle: .main).instantiateViewController(withIdentifier: "AdsDetailVC") as? AdsDetailVC
        vc?.configAds(ads: ad, category: category)
        self.present(vc!, animated: true, completion: nil)
    }
}

