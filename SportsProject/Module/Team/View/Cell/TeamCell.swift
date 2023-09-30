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

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTypeLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        presenter = TeamPresenter(cell: self)
    }

}

extension TeamCell: TeamCellProtocol {
    
    
    func displayName(name: String) {
        playerNameLabel.text = name
    }
    
    func displayNumber(number: String) {
        playerNumberLabel.text = number
    }
    
    func displayRating(rating: String) {
        playerRatingLabel.text = rating
    }
    
    func displayType(type: String) {
        playerTypeLabel.text = type
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
            case .failure(let error):
                print(error.localizedDescription)
                self.playerImageView.image = UIImage(systemName: "person.fill")
            }
        }
    }
      
}
