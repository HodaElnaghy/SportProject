//
//  TeamCustomCell.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit

class TeamCustomCell: UICollectionViewCell {

   
    @IBOutlet weak var TeamCusonCellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TeamCusonCellBackground.layer.cornerRadius = 16
        TeamCusonCellBackground.clipsToBounds = true
    }

}
