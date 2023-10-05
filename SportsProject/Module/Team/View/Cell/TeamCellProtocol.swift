//
//  TeamCellProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation
import UIKit

protocol TeamCellProtocol: AnyObject {
    func displayName(name: String)
    func displayNumber(number: String)
    func displayRating(rating: String)
    func displayType(type: String)
    func displayImage(by stringURL: String?)
//    func displayImage(image: UIImage)
}
