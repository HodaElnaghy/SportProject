//
//  TeamCell.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import UIKit
import Kingfisher
import Alamofire

class TeamCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.dropShadow()
    }

}

// MARK: - Team Cell Protocol
extension TeamCell: TeamCellProtocol {
    
    func displayName(name: String) {
        playerNameLabel.text = name
    }
    
    func displayNumber(number: String) {
//        playerNumberLabel.text = number
    }
    
    func displayRating(rating: String) {
//        playerRatingLabel.text = rating
    }
    
    func displayType(type: String) {
//        playerTypeLabel.text = type
    }
    
    func displayImage(by stringURL: String?) {
        playerImageView.downloadImageFrom(stringURL)
        if stringURL == nil {
            playerImageView.image = UIImage(named: "player")
        }
    }
      
}

