//
//  DataInternetManager.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import Foundation
import UIKit

/**
 The purpose of the `SharedManager` is to use in this methods in multiple classe's without creating class instance in different classes
 
 The `SharedManager` class is a subclass of the `NSObject`,
 */
class DataInternetManager: NSObject {
    
    /// single instance object for sharing the code without creating multiples instances
    @objc class var shared : DataInternetManager{
        
        struct singleton{
            static let instance = DataInternetManager()
        }
        return singleton.instance
    }
    
        
    /** Checking whether data is avaible or not in Array based that we have to show dataView or NoData available label
     
     - Parameters:
     - noDataLbl: Label
     - tableView: displaying data TableView
     /   - count: Api Response Data passing.
     */
    func showTableOrNoData(_ noDataLbl: UILabel, tableView: UITableView, count: Int) {
        
        if count == 0 {
            noDataLbl.isHidden = false
            tableView.isHidden = true
        }
        else {
            noDataLbl.isHidden = true
            tableView.isHidden = false
        }
        
        tableView.reloadData()
    }
    
    /// internet connectivity status label
    var kNoConnectivityLabel : UILabel!


    /// Adding Label if Internet is not available.
    func addNoInternetConnectionLabel() {
        
        if  kNoConnectivityLabel == nil {
            kNoConnectivityLabel = UILabel(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 0))
            kNoConnectivityLabel.backgroundColor = UIColor.red
            kNoConnectivityLabel.text = "No Internet Connection"
            kNoConnectivityLabel.textColor = UIColor.white
            kNoConnectivityLabel.textAlignment = .center
            appDelegate.window?.rootViewController?.view.addSubview(kNoConnectivityLabel)
        }
        
        appDelegate.window?.rootViewController?.view.bringSubviewToFront(kNoConnectivityLabel)
        
        UIView.animate(withDuration: 1.0, animations: {
            var frame = self.kNoConnectivityLabel.frame
            frame.origin.y = SCREEN_HEIGHT-40
            frame.size.height = 40
            self.kNoConnectivityLabel.frame = frame;
        }, completion: { (_) in
            
        })
    }
    
}






