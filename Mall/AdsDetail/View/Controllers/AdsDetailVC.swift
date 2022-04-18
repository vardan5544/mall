//
//  AdsDetailVC.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 16.04.22.
//

import UIKit

class AdsDetailVC: UIViewController {
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var imagePageControll: UIPageControl!
    @IBOutlet weak var adImageCV: UICollectionView!
    @IBOutlet weak var favoriteButtonView: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var adPriceLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var adsDetailTV: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let rowHeight = 70
    
    var values: [String: Any] = ["Title": "jijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijijiji", "Price": 123, "Morkur": "Jajumbaa", "Title1": "llp", "Price1": 123, "Morkur1": "Jajumbajijijijijijijijijijijijia", "Title2": "", "Price2": 123, "Morkur2": "Jajumbaa", "Title3": "", "Price3": 123, "Morkur3": "Jajumbajijijijijijijijijijia"]
    var key = [String]()
    var valu = [Any]()
    
    var ads: Ads?
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adsDetailTV.frame.size.height += (self.view.bounds.height + CGFloat(60 * values.count))
        //adsDetailTV.layoutIfNeeded()
//        mainContentView.layoutIfNeeded()
        for (key, value) in values {
            
            self.key.append(key)
            self.valu.append(value)
        }
        
        adsDetailTV.isScrollEnabled = false
        configTableView()
        imagePageControll.isUserInteractionEnabled = false
        configFavoriteButton() // favorite button
        configElements()
        adImageCVDelegates()
        //mainScrollView.contentOffset = CGPoint(x: 0, y: mainScrollView.frame.height + 200)
       // self.view.layoutIfNeeded()
        //mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 350, right: 0)
        
  }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            tableViewHeight.constant = adsDetailTV.contentSize.height

//        tableViewHeight.constant = adsDetailTV.contentSize.height
//        //adsDetailTV.frame.size.height += CGFloat(rowHeight * values.count)
//        //tableViewHeight.constant += CGFloat(rowHeight * values.count)
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        //adsDetailTV.frame.size.height += CGFloat(rowHeight * values.count)
//        //tableViewHeight.constant += CGFloat(rowHeight * values.count)
//        self.view.layoutIfNeeded()
        
    }
    
    // MARK: - Config TableView
    
    func configTableView() {
        adsDetailTV.register(UINib(nibName: "AdsContactCell", bundle: .main), forCellReuseIdentifier: "AdsContactCell")
        adsDetailTV.register(UINib(nibName: "AdsDetailCell", bundle: .main), forCellReuseIdentifier: "AdsDetailCell")
        //adsDetailTV.estimatedRowHeight = 100
        //adsDetailTV.rowHeight = UITableView.automaticDimension
        adsDetailTV.delegate = self
        adsDetailTV.dataSource = self
    }
    
    // MARK: - Config Ad Image Collection View
    
    func adImageCVDelegates() {
        
        adImageCV.delegate = self
        adImageCV.dataSource = self
    }
    
    // MARK: - Config Favorite button
    
    func configFavoriteButton() {
        
        let favPointSize = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        if isFavorite {
            
            let favImage = UIImage(systemName: "heart.fill", withConfiguration: favPointSize)
            favoriteButtonView.setImage(favImage, for: .normal)
        } else {
            let favImage = UIImage(systemName: "heart", withConfiguration: favPointSize)
            favoriteButtonView.setImage(favImage, for: .normal)
        }
    }
    
    // MARK: - Config ads elements from data
    
    func configElements() {
        
        guard let ads = ads else { return }

        self.contactButton.setTitle("\(ads.id)", for: .normal)
        self.titleLabel.text = ads.name
        //self.adPriceLabel.text = ads.
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            print(ads.id, "AD ID")
            if ads.image != "" {
                
                if let data = try? Data(contentsOf: URL(string: ads.image)!) {
                //self.adImageView.image = UIImage(data: data)
                }
                
            } else if ads.image == "" {
                
                //self.adImageView.image = UIImage(systemName: "photo.artframe")
                //self.adImageView.tintColor = UIColor.gray
            }
        }
        print(ads.name, "Ads Page Print")
    }
    
    func configAds(ads: Ads) {
        self.ads = ads
    }
    
    // MARK: - Favorite Button click action
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        isFavorite = !isFavorite
        configFavoriteButton()
    }
}

extension AdsDetailVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdImageViewCell", for: indexPath) as! AdImageViewCell
        cell.setupimage(url: ads?.image)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(adImageCV.contentOffset.x / self.view.frame.width, "Content offset x")
                imagePageControll.currentPage = Int((adImageCV.contentOffset.x / self.view.frame.width))
    }
    

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }

}

extension AdsDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {

            return values.count
        } else if section == 1 {
            print(values.count)
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableViewHeight.constant += tableView.rowHeight
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdsContactCell", for: indexPath) as? AdsContactCell

            return cell!
        } else if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdsDetailCell", for: indexPath) as? AdsDetailCell
        
        
        cell?.configElements(key: key[indexPath.row], value: valu[indexPath.row])
        return cell!
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // adsDetailTV.frame.size.height = CGFloat(150 * values.count)
        //self.view.layoutIfNeeded()
       // if indexPath.section == 0 {
        return CGFloat(rowHeight)
//        } else {
//            return 200
//        }
    }
}

