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
//    func fetchingDataSuccess()
//    func showError(error: String)
    func reloadCollectionView()
}
