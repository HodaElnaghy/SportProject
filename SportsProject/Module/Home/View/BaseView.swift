//
//  BaseView.swift
//  SportsProject
//
//  Created by Mohammed Adel on 09/10/2023.
//

import Foundation


protocol BaseView: AnyObject {
    func displayMessage(_ message: String, theme: MessagesTheme)
}
