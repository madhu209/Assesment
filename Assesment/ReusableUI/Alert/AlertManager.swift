//
//  AlertManager.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import Foundation
import UIKit

internal final class AlertManager {
    
    static let shared = AlertManager()
    private var presenter: UIViewController?

    /** For Displaying Alert based on Validations, Information Or Getting error's from Web API
     
     - Parameters:
     - alertMessage: Alert Message
     */
    func showAlert(_ alertMessage: String) {
        
        DispatchQueue.main.async(execute: {
            
            let alert = UIAlertController(title: "", message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    
}
