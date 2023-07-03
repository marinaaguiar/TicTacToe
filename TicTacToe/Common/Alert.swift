//
//  Alert.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 7/3/23.
//

import UIKit

struct Alert {

    static func showBasics(title: String, message: String, vc: UIViewController, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let continueAction = UIAlertAction(title: "Continue", style: .destructive) { _ in
            completion?()
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(continueAction)

        vc.present(alert, animated: true)
    }
}
