//
//  UICollectionViewCell + identifier.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        //return self.description()
        return String(describing: Self.self)
    }
}
