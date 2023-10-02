//  Alert.swift
//  SportsProject
//
//  Created by Hend on 02/10/2023.
//

import UIKit

extension UIViewController {
    func show(errorAlert error: NSError) {
        show(error.localizedDescription)
    }
    
    func show(messageAlert title: String, message: String? = "", actionTitle: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        show(title, message: message, actionTitle: actionTitle, action: action)
    }
    
    fileprivate func show(_ title: String, message: String? = "", actionTitle: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let closeAction = NSLocalizedString("Close", comment: "")
        alert.addAction(UIAlertAction(title: closeAction, style: .cancel, handler: action))
        if let _actionTitle = actionTitle {
            alert.addAction(UIAlertAction(title: _actionTitle, style: .default, handler: action))
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
