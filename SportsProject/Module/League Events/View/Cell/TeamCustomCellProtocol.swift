//
//  TeamCustomCellProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

protocol TeamCustomCellProtocol: AnyObject {
    func displayName(_ name: String)
    func displayImage(by stringURL: String?)
}
