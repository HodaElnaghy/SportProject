//
//  LeaguesCell.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import UIKit

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
        
    }
    
    
    func configureCell(by leaguesModel: LeaguesModel) {
        leagueTitleLabel.text = leaguesModel.league_name
        print("UUUUUUUUUUU")
        
    }
}
