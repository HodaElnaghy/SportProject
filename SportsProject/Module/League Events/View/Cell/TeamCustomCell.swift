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
        TeamCusonCellBackground.dropShadow()
    }
    
}

extension TeamCustomCell: TeamCustomCellProtocol {
    func displayName(_ name: String) {
        teamNameLabel.text = name
    }
    
    func displayImage(by stringURL: String?) {
        teamLogoImageView.downloadImageFrom(stringURL)
    }
    
}
