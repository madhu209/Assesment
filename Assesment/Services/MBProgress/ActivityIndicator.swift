//
//  ActivityIndicator.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import Foundation
import MBProgressHUD

internal final class ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    // MARK: -
    /// Method for showing activity indicator.
    func showActivity() {
        
        DispatchQueue.main.async(execute: {
            MBProgressHUD.showAdded(to: (appDelegate.window)!, animated: true)
            appDelegate.window?.rootViewController?.view.bringSubviewToFront(MBProgressHUD())
        })
        
    }

    /// Method for hiding activity indicator.
    func hideActivity() {
        
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: (appDelegate.window)!, animated: false)
        })
    }
    
}
