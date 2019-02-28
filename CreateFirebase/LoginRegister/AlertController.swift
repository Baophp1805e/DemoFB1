//
//  AlertController.swift
//  CreateFirebase
//
//  Created by Bao on 2/13/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
class AlertController {
    static func showAlert(inViewController: UIViewController, title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        inViewController.present(alert, animated: true, completion: nil)
        
    }
}
extension UIViewController{
    @objc func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

