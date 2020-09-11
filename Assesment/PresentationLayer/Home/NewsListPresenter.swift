//
//  HomeViewPresenter.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class NewsListPresenter {
    
    private weak var viewDelegate: NewsListViewDelegate?
    
    init(view: NewsListViewDelegate) {
        self.viewDelegate = view
    }
    
}

extension NewsListPresenter: NewsListPresenterProtocol {
    
    func viewDidLoad() {
                
        viewDelegate?.setUpUI()
        
        getNewsListFromApi(currentPageIndex: 1)
    }
        
    /**
     News list API calling
     */
    func getNewsListFromApi(currentPageIndex: Int) {
        
        ServiceManager.shared.callToGetDataFromServer(appendUrlString: NewsListEndPoints.mostViewed, withIndicator: currentPageIndex == 1 ? true : false, completionHandler: { (jsonOutput) in
            
            self.dataBindingToModel(jsonOutput as? NSDictionary ?? NSDictionary())

        })
    }
    
    /** Api Response Binding to News List Model Class And checking whether Array count is empty or not
     
     If *newsListArray* does not have values then showing Label No Data Available, If *newsListArray* does have values then hidding NoDataLbl and Displaying TableView and Reloading the TableView to Load data in TableView cells UI
     
     - Parameter jsonDictionary: Response json object
     */
    func dataBindingToModel(_ jsonDictionary: NSDictionary) {
        
        let payloadArray = jsonDictionary["results"] as? NSArray ?? NSArray()
        
        #if DEBUG
        print(payloadArray)
        #endif
        
        var newsListArray = [MostViewed]()
        
        // insert each item into database
        for i in 0..<payloadArray.count {
            let newsObj = MostViewed(dict: payloadArray.object(at: i) as! [String : Any])
            newsListArray.append(newsObj)
        }
        
        #if DEBUG
        print(newsListArray)
        #endif
        
        viewDelegate?.successApiData(responseArray: newsListArray)
                
    }
    
    
}
