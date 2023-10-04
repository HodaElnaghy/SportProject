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
        downloadImageFrom(stringURL, to: homeTeamImageView)
    }
    
    func displayAwayTeamImage(by stringURL: String?) {
        downloadImageFrom(stringURL, to: awayTeamImageView)
    }
    
    private func downloadImageFrom(_ stringURL: String?, to imageView: UIImageView) {
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let imageRes):
                imageView.image = imageRes.image
            case .failure(_):
                imageView.image = UIImage(named: "heart.fill")
            }
        }
    }
}
