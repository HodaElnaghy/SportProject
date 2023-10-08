//
//  UIViewController + Identifier.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import UIKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
}

