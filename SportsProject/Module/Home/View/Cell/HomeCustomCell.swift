//
//  HomeCustomCell.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit

class HomeCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sportImage.layer.cornerRadius = 16
        sportImage.clipsToBounds = true
    }
}

// MARK: - HomeCellProtocol
extension HomeCustomCell: HomeCellProtocol {
    func displaySportName(_ name: String) {
        sportName.text = name
    }
    
    func displaySportImage(by imageName: String) {
        sportImage.image = UIImage(named: imageName)
    }
}
