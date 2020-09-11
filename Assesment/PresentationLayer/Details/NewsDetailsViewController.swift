//
//  NewsDetailsViewController.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import UIKit

/**
 The purpose of the `NewsDetailsViewController` is to show the Selcted News information in detail way
 
 There's a matching scene in the *Main.storyboard* file, and in that scene there is a `UIScrollView` with `UILabels` design. Go to Interface Builder for details.
 
 The `NewsDetailsViewController` class is a subclass of the `UIViewController`.
 */
class NewsDetailsViewController: UIViewController {

    /// object that holds the selected News object from the previous screen
    var newsObj: MostViewed!
    
    /// Label to show the News Name
    @IBOutlet weak var newsTitleLbl: UILabel!
    
    /// Label to show the News Name
    @IBOutlet weak var newsDescriptionLbl: UILabel!
    
    /// Scroll to Display the News Images in horezntal direction
    @IBOutlet weak var imagesHorizentalScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    /// View load method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUI()
        
    }
    
    /// UI binding logics
    func setUI() {
        
        self.navigationItem.title = "News Details"
        
        newsTitleLbl.text = (newsObj.title)!
        newsDescriptionLbl.text = (newsObj.abstract)!

        createImages()
        
    }
    
    func createImages() {
        
        imagesHorizentalScrollView.layoutIfNeeded()
        
        var x_origin: CGFloat = 0
        
        print(newsObj.mediaArray)
        
        for i in 0..<(newsObj?.mediaArray.count)! {
            
            let newsImage = UIImageView()
            newsImage.image = UIImage(named: "default.png")
            newsImage.frame = CGRect(x: x_origin, y: 0, width: SCREEN_WIDTH, height: imagesHorizentalScrollView.frame.size.height)
            newsImage.tag = i
            newsImage.isUserInteractionEnabled = false
            newsImage.contentMode = .scaleAspectFill
            newsImage.loadImageUsingCacheUrlString(urlString: (newsObj?.mediaArray[i].imageurl)!)
            imagesHorizentalScrollView.addSubview(newsImage)
            
            x_origin = x_origin+SCREEN_WIDTH
        }
        
        imagesHorizentalScrollView.contentSize = CGSize(width: x_origin, height: 0)
        
        pageControl.numberOfPages = (newsObj?.mediaArray.count)!
        pageControl.currentPage = 0
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: ScrollView Dllegate Methods
extension NewsDetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentPage = scrollView.contentOffset.x/SCREEN_WIDTH
        pageControl.currentPage = Int(currentPage)
    }
}

