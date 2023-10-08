//
//  LeaguesCell.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import UIKit
import Kingfisher

class LeaguesCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // disable selection style
        selectionStyle = .none
        // round card view
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        cardView.dropShadow()
        
        self.leagueImageView.layer.masksToBounds = false
        self.leagueImageView.layer.cornerRadius = leagueImageView.frame.size.width/2
        self.leagueImageView.clipsToBounds = true
        
        // remove separator, shift separatorInset to rigt by 500
        self.separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func linkButtonPressed(_ sender: Any) {
        print("No link in API")
    }
    
}


// MARK: - LeaguesCellProtocol
extension LeaguesCell: LeaguesCellProtocol {
    func displayLeagueImage(by stringURL: String?) {
        leagueImageView.downloadImageFrom(stringURL)
        if stringURL == nil {
            leagueImageView.image = UIImage(named: "leagueDefault")
        }
    }
    
    func displayLeagueTitle(title: String) {
        leagueTitleLabel.text = title
    }
    
}
