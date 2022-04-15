//
//  MainPageTableViewCell.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 14.04.22.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    
    func selectCell(cell: MainPageTableViewCell, indexPath: IndexPath)
}

class MainPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!

    @IBOutlet weak var sectionText: UILabel!
    
    weak var delegate: TableViewCellDelegate?
    var network : NetworkingService?
    
    var search = false
    var result : [Ads] = [Ads]()
    var sectionModel : Category?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
            self.mainCollectionView.delegate = self
            self.mainCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(section: Category, searching: Bool, res: [Ads]){
        
            self.sectionModel = section
            self.search = searching
            self.result = res
            self.mainCollectionView.reloadData()
    }
}

extension MainPageTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if search{
            return result.count
        }else{
            return sectionModel?.ads.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        if search{
            let update = result[indexPath.row]
            cell.priceLbl.text = update.name
            cell.aboutLbl.text = update.adDescription
            if let url = URL(string: update.image){
                
                DispatchQueue.main.async {
                    cell.imageView.af.setImage(withURL: url)
                }
                
            } else {
                cell.imageView.image = UIImage(systemName: "photo.artframe")
            }
        } else {
            let model = sectionModel?.ads[indexPath.row]
            cell.priceLbl.text = model?.name// Instance Alamofire extension point.
            cell.aboutLbl.text = model?.adDescription
            if let url = URL(string: model?.image ?? "") {
                
                DispatchQueue.main.async {
                    cell.imageView.af.setImage(withURL: url)
                }
            } else {
                cell.imageView.image = UIImage(systemName: "photo.artframe")

            }
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 100, height: 100)
//    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectCell(cell: self, indexPath: indexPath)
    }
    
}

