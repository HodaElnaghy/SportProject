//
//  LeagueCustomCell.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import UIKit
import Kingfisher

class LeagueCustomCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var leagueLogoImageView: UIImageView!
    
    @IBOutlet weak var eventAwayTeamLabel: UILabel!
    @IBOutlet weak var eventHomeTeamLabel: UILabel!

    @IBOutlet weak var eventFinalResult: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    @IBOutlet weak var eventStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundImage.layer.cornerRadius = 20
        backgroundImage.clipsToBounds = true
        self.leagueLogoImageView.layer.cornerRadius = min(leagueLogoImageView.frame.size.width, leagueLogoImageView.frame.size.height) / 2.0


        self.leagueLogoImageView.layer.masksToBounds = true

        // Add a circular black stroke (border) around the image view
        self.leagueLogoImageView.layer.borderWidth = 1.0 // Adjust the border width as needed
        self.leagueLogoImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    


}

extension LeagueCustomCell: LeagueCustomCellProtocol {
    func displayEventAwayTeamName(_ name: String) {
        eventAwayTeamLabel.text = name
    }
    
    func displayEventHomeTeamName(_ name: String) {
        eventHomeTeamLabel.text = name
    }
    
    func displayFinalResult(_ result: String) {
        eventFinalResult.text = result
    }
    
    func diaplayEventTime(_ time: String) {
        eventTimeLabel.text = time
    }
    
    func diaplayEventDate(_ date: String) {
        eventDateLabel.text = date
    }
    
    func displayEventState(_ state: String) {
        eventStatusLabel.text = state
    }
    
    func displayHomeTeamImage(by stringURL: String?) {
        homeTeamImageView.downloadImageFrom(stringURL, placeHolder: "leagueDefault")
    }
    
    func displayAwayTeamImage(by stringURL: String?) {
        awayTeamImageView.downloadImageFrom(stringURL, placeHolder: "leagueDefault")
    }
    
    func displayLeagueImage(by stringURL: String?) {
        leagueLogoImageView.downloadImageFrom(stringURL, placeHolder: "leagueDefault")
    }
}
