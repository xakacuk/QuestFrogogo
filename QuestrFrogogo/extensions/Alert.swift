//
//  Alert.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showErrorAlertMessadge(title: String, messadge: String) {
        let alert = UIAlertController(title: title, message: messadge, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showCompletionAlert(completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Success", message: "New User Сreate!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
