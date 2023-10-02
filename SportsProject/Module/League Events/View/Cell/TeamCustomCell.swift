//
//  TeamCustomCell.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit
import Kingfisher

class TeamCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var TeamCusonCellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TeamCusonCellBackground.layer.cornerRadius = 16
        TeamCusonCellBackground.clipsToBounds = true
    }
    
}

extension TeamCustomCell: TeamCustomCellProtocol {
    func displayName(_ name: String) {
        teamNameLabel.text = name
    }
    
    func displayImage(by stringURL: String?) {
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }
        
        teamLogoImageView.kf.indicatorType = .activity
        teamLogoImageView.kf.setImage(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageRes):
                teamLogoImageView.image = imageRes.image
            case .failure(_):
                teamLogoImageView.image = UIImage(systemName: "heart.fill")
            }
        }
    }
    
}
