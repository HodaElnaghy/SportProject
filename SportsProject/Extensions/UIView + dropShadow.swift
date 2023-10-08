//
//  UIView + dropShadow.swift
//  SportsProject
//
//  Created by Mohammed Adel on 02/10/2023.
//

import UIKit

extension UIView {
    
    // MARK: - Drop Shadow Extension
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
