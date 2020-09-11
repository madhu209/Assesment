//  Constants.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//


import Foundation
import UIKit

/// Instance for stores Width of the Device
let SCREEN_WIDTH =  UIScreen.main.bounds.size.width

/// Instance for stores Height of the Device
let SCREEN_HEIGHT =  UIScreen.main.bounds.size.height

/// This instace for sharing inside of Appdelegate Objects and Fuctions
var appDelegate = UIApplication.shared.delegate as! AppDelegate

/// If any thing getting error but not message from API then Displaying the default Message
let kWrongMessage = "Some thing went wrong\nPlease try again"

/// The completionHandler for callback's for Triggering with data after compltion of the Task
typealias CompletionHandler = (_ data: Any) -> Void
