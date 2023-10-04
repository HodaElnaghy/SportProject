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
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }
        
        // Download image By Kingfisher
        playerImageView.kf.indicatorType = .activity
        playerImageView.kf.setImage(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageResult):
                playerImageView.image = imageResult.image
            case .failure(let error):
                print(error.localizedDescription)
                playerImageView.image = UIImage(systemName: "person.fill")
            }
        }
    }
      
}

