//
//  EndPoint.swift
//  Assesment
//
//  Created by Madhusudhan Reddy Putta on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import Foundation

@objc internal final class Endpoint: NSObject {

    /// APP_KEY object that registered with New York Times API services
    
    static var staticEndpoint: String {
                
        if isDebug  { return "http://api.nytimes.com/svc/mostpopular/v2/" }
        else { return "http://api.nytimes.com/svc/mostpopular/v2/" }
    }
        
    static var isDebug: Bool {

        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
}

@objc internal final class NewsListEndPoints: NSObject {
    
    static var APP_KEY : String { "Cd2gTxTBjoAv1s7iLfzQLOqw0OiVlFHH" }

    static var mostViewed = "mostviewed/all-sections/7.json?api-key=\(APP_KEY)"
    
}
