//
//  UIImageView + kingFisher.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import UIKit
import Kingfisher


extension UIImageView {
   
    func downloadImageFrom(_ stringURL: String?) {
        guard let stringURL = stringURL else { return }
        guard let url = URL(string: stringURL) else { return }

        kf.indicatorType = .activity
        let resource = KF.ImageResource(downloadURL: url, cacheKey: stringURL)
        kf.setImage(with: resource)
    }
}
