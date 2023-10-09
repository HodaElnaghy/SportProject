//
//  TeamViewControllerProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation

protocol TeamViewControllerProtocol: AnyObject {
    func showIndicator()
    func hideIndicator()
    func reloadCollectionView()
    func updatePlayerTypeLabel(type: String?)
}
