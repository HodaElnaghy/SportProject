//
//  UIViewController + SwiftMessages.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import UIKit
import SwiftMessages

// Mapping MessagesTheme with Them.
enum MessagesTheme {
    case info
    case success
    case warning
    case error
}

extension UIViewController {
    
    func displayMessage(_ message: String, theme: MessagesTheme) {
        let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
        switch theme {
        case .info:
            view.configureTheme(.info)
            view.configureContent(title: "Info", body: message, iconText: "🤗")
        case .success:
            view.configureTheme(.success)
            view.configureContent(title: "Success", body: message, iconText: "🎉")
        case .warning:
            view.configureTheme(.warning)
            view.configureContent(title: "Error", body: message, iconText: "😞")
        case .error:
            view.configureTheme(.error)
            view.configureContent(title: "Error", body: message, iconText: "😓")
        }
        
        view.configureDropShadow()
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
    
}
