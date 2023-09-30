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
    
//    private var presenter: TeamPresenter!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    //@IBOutlet weak var playerTypeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        // Initialization code
//        presenter = TeamPresenter(cell: self)
        
        containerView.dropShadow()
        
    }

}

extension TeamCell: TeamCellProtocol {
    
    
    func displayName(name: String) {
        playerNameLabel.text = name
    }
    
    func displayNumber(number: String) {
       // playerNumberLabel.text = number
    }
    
    func displayRating(rating: String) {
       // playerRatingLabel.text = rating
    }
    
    func displayType(type: String) {
       // playerTypeLabel.text = type
    }
    
    func displayImage(by stringURL: String?) {
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }
        
        // Download image By Kingfisher
        playerImageView.kf.indicatorType = .activity
        playerImageView.kf.setImage(with: url) { result in
            switch result {
                
            case .success(let imageResult):
                self.playerImageView.image = imageResult.image
                print("H")
            case .failure(let error):
                print(error.localizedDescription)
                self.playerImageView.image = UIImage(systemName: "person.fill")
            }
            
        }
        
    }
      
}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
