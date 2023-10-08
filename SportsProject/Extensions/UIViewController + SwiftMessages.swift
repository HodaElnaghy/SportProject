//
//  UIViewController + SwiftMessages.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import UIKit
import SwiftMessages

extension UIViewController {
    func displayMessage(message: String, messageError: Bool) {
        let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
        if messageError == true {
            view.configureTheme(.warning)
            view.configureContent(title: "Warning", body: message, iconText: "😞")
        } else {
            view.configureTheme(.success)
            view.configureContent(title: "Success", body: message, iconText: "🎉")
        }
        
        view.configureDropShadow()
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        view.button?.isHidden = true

        SwiftMessages.show(view: view)
    }
}
