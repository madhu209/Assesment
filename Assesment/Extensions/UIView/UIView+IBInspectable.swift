//
//  UIView+IBInspectable.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//


/*:
 
 #Overview
 
 This is for extentions of UI Elements for Corner Radius, Border Width , Border color and Image saving in cache.
 
 */

import Foundation
import UIKit

extension UIView {
    
    /**
     
     The radius to use when drawing rounded corners for the layer’s background.
     The default value of this property is 0.0.
     The property can display in Drag and drop file to change value for Every UIView element
     */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /**
     
     The width of the layer’s border.
     The default value of this property is 0.0.
     The property can display in Drag and drop file to change value for Every UIView element
     */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /**
     
     The color of the layer’s border.
     The default value of this property is an opaque black color.
     The property can display in Drag and drop file to change value for Every UIView element
     */
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var rightLineColor : UIColor {
        get {
            return UIColor.red
        }set {
            let border: CALayer = CALayer()
            border.borderColor = rightLineColor.cgColor
        }
    }
    
    @IBInspectable var rightLineWidth : CGFloat {
        
        get {
            return 5
        }
        set{
            let border: CALayer = CALayer()
            border.borderColor = UIColor.orange.cgColor
            self.frame = CGRect(x: self.frame.size.width - rightLineWidth, y: 0, width: rightLineWidth, height: self.frame.size.height)
            border.borderWidth = rightLineWidth
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
    
    
    /**
     A Boolean value that determines whether the view is hidden.
     Setting the value of this property to true hides the receiver and setting it to false shows the receiver. The default value is false.
     */
    func isMyHidden() {
        if isHidden == true
        {
            isHidden = false
        }
        else if isHidden == false
        {
            isHidden = true
        }
    }
    func changeAlpha() {
        if alpha == 0.0 {
            alpha = 1.0
        }
        else if alpha == 1.0 {
            alpha = 0.0
        }
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
}



/**
 
 #Overview
 
 This is for extentions of UIImageView saving loaded image in cache.
 
 */

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    /**
     To load the image
     
     #1. Check image is avaialble in cache or not.
     A. If not Download the image from URL and save in cache.
     B. If the image is avaible in cache then direct pass the image to imageview.
     
     
     - parameters:
     - urlString: The urlString in the Image URL, cannot be empty
     
     */
    func loadImageUsingCacheUrlString(urlString: String) {
        self.image = #imageLiteral(resourceName: "default")
        
        var urlStr = urlString.replacingOccurrences(of: " ", with: "%20")
        
        urlStr = urlStr.replacingOccurrences(of: "\\", with: "/")
        
        #if DEDEBUG
        print(urlStr)
        #endif
        
        //Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlStr as NSString) {
            self.image = cachedImage
            return
        }
        
        let url = NSURL(string: urlStr)
        if url != nil {
            URLSession.shared.dataTask(with: url! as URL){
                data,response,error  in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = #imageLiteral(resourceName: "default")
                    }
                    
                    print("fail to download Image from FB with error: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let downloadedImage = UIImage(data: data!)
                    {
                        imageCache.setObject(downloadedImage, forKey: urlStr as NSString)
                        self.image = downloadedImage
                    }
                }
                }.resume()
        }
    }
}
