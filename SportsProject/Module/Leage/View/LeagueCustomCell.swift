//
//  LeagueCustomCell.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit

class LeagueCustomCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var finishedMatchLabel: UILabel!
    @IBOutlet weak var finishedMatchDate: UILabel!
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
   
    @IBOutlet weak var finishedMatchTime: UILabel!
    @IBOutlet weak var teamOneLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundImage.layer.cornerRadius = 20
        backgroundImage.clipsToBounds = true
    }

}
