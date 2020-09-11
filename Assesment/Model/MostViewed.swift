//
//  MostViewed.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

/**
 The purpose of the `MostViewed` is to save News information in parameters
 
 The `MostViewed` class is a subclass of the `NSObject`,
 */

class MostViewed: NSObject {
    
    /// String object that holds News ID
    var id: String?
    
    /// String object that holds News Title
    var title: String?
    
    /// String object that holds News Written By Name
    var byline: String?
    
    /// String object that holds News Published Date
    var published_date: String?
    
    /// String object that holds News Description
    var abstract: String?

    var mediaArray = [Media]()
    
    /** Getting data from dictionary and storing in each object with help of Dictionary key's
     
     - Parameter dict: News Info With keys and values
     */
    init(dict: [String : Any]) {
        
        super.init()
        
        id = dict["id"] as? String ?? ""
        title = dict["title"] as? String ?? ""
        byline = dict["byline"] as? String ?? ""
        published_date = dict["published_date"] as? String ?? ""
        abstract = dict["abstract"] as? String ?? ""
        
        mediaArray.removeAll()

        var mediaDataArray = dict["media"] as? NSArray ?? NSArray()
        
        if mediaDataArray.count != 0 {
            let dict = mediaDataArray[0] as? NSDictionary ?? NSDictionary()
            mediaDataArray = dict["media-metadata"] as? NSArray ?? NSArray()
        }
        
        // insert each item into database
        for i in 0..<mediaDataArray.count {
            let mediaObj = Media(dict: mediaDataArray.object(at: i) as! [String : Any])
            self.mediaArray.append(mediaObj)
        }
        
    }
    
}

class Media: NSObject {
    
    /// String object that holds Media url LInk
    var imageurl: String?
    
    /** Getting data from dictionary and storing in each object with help of Dictionary key's
     
     - Parameter dict: News Info With keys and values
     */
    init(dict: [String : Any]) {
        
        super.init()
        
        imageurl = dict["url"] as? String ?? ""
        
    }
    
}



