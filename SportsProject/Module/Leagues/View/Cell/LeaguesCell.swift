//
//  LeaguesCell.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import UIKit
import Kingfisher

class LeaguesCell: UITableViewCell {
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // disable selection style
        selectionStyle = .none
        // round card view
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        // remove separator, shift separatorInset to rigt by 500
        self.separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func linkButtonPressed(_ sender: Any) {
        print("No link in API")
    }
    
}

extension LeaguesCell: LeaguesCellProtocol {
    func displayLeagueImage(by stringURL: String?) {
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }
        
        // Download image By Kingfisher
        leagueImageView.kf.indicatorType = .activity
        leagueImageView.kf.setImage(with: url) { result in
            switch result {
                
            case .success(let imageResult):
                self.leagueImageView.image = imageResult.image
            case .failure(let error):
                print(error.localizedDescription)
                self.leagueImageView.image = UIImage(systemName: "heart.fill")
            }
        }
    }
    
    func displayLeagueTitle(title: String) {
        leagueTitleLabel.text = title
    }
    
}