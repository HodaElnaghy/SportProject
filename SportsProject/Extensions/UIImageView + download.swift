//
//  UIImageView + kingFisher.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import UIKit
import Kingfisher


extension UIImageView {
    
    func downloadImageFrom(_ stringURL: String?, placeHolder: String = "leagueDefault") {
        guard let stringURL = stringURL, let url = URL(string: stringURL) else {
            image = UIImage(named: placeHolder)
            return
        }
        kf.indicatorType = .activity
        kf.setImage(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageRes):
                image = imageRes.image
            case .failure(let error):
                print(error.localizedDescription)
                image = UIImage(named: placeHolder)
            }
        }
    }
}
