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
    @IBOutlet weak var teamTwoImage: UIImageView!
    
    @IBOutlet weak var finishedMatchTime: UILabel!
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var teamOneImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
