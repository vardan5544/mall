//
//  Extensions.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 13.04.22.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Show alert function
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
