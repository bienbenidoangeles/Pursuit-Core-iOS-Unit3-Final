//
//  ViewController+Extension.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String, completion: ((UIAlertAction)->Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(alertButton)
        present(alertController, animated: true, completion: nil)
    }
}
