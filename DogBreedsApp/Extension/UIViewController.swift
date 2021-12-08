//
//  UIViewController.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

extension UIViewController {
    
    @objc
    func showAlert(with message: String?) {
        let alertVC = UIAlertController(title: "DogBreedsApp", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true)
    }
    
    @objc
    func showErrorAlert(with message: String?) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true)
    }
}
