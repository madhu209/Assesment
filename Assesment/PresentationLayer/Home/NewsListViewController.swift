//
//  NewsListViewController.swift
//  Assesment
//
//  Created by Madhusudhan on 11/09/20.
//  Copyright © 2020 mLabs. All rights reserved.
//

import UIKit

/**
 The purpose of the `RootViewController` is to fetch the MostViewed New list from the api and display the details on a tableview cell
 
 There's a matching scene in the *Main.storyboard* file, and in that scene there is a `UITableView` with `UITableViewCell` design. Go to Interface Builder for details.
 
 The `RootViewController` class is a subclass of the `UIViewController`, and it conforms to the `UITableViewDataSource`, `UITableViewDelegate` and `UIScrollViewDelegate`  protocol.
 */

protocol NewsListViewDelegate: AnyObject {
    func setUpUI()
    func successApiData(responseArray: [MostViewed])
}

class NewsListViewController: UIViewController {
    
    /// object that holds Page number of the API
    var currentPageIndex = 1
    
    /// array object that holds table data
    var newsListArray = [MostViewed]()
    
    /// tableview for displaying the newss list
    @IBOutlet weak var newsTableView: UITableView!
    
    /// label for displaying the message if there is no data
    @IBOutlet weak var noDataLbl: UILabel!

    var newsListPresenter: NewsListPresenter!
    
    /// View load method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        newsListPresenter = NewsListPresenter(view: self)
        newsListPresenter.viewDidLoad()
        
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == Segues.shared.DETAILS_IDENTIFIER {
            let detailsVC = segue.destination as? NewsDetailsViewController
            detailsVC?.newsObj = sender as? MostViewed
        }
        
     }
    
    
}

extension NewsListViewController: NewsListViewDelegate {
    
    func setUpUI() {
                
        newsTableView.isEditing = false
        
    }
    
    func successApiData(responseArray: [MostViewed]) {
        
        newsTableView.contentOffset = CGPoint(x: 0, y: 0)

        newsListArray = responseArray
        
        DataInternetManager.shared.showTableOrNoData(self.noDataLbl, tableView: self.newsTableView, count: newsListArray.count)
        
    }
}

extension NewsListViewController {
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        
        sender.title = newsTableView.isEditing == false ? "Done" : "Edit"
        
        newsTableView.isEditing = !newsTableView.isEditing
    }
    
}

// MARK: - TableView DataSource and Delegate Methods
extension NewsListViewController: UITableViewDataSource {
        
    /// To display number of rows in each section of table
    /// - Parameters:
    ///   - tableView: tableView object that displays news list
    ///   - section: current section index
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListArray.count
    }
    
    /// To set the values for fields on the each cell of the row
    /// - Parameters:
    ///   - tableView: tableView object that displays news list
    ///   - indexPath: current indexpath object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom_CellID", for: indexPath) as! NewsTVCell
        cell.selectionStyle = .none
        cell.newsObj = newsListArray[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
        
}

extension NewsListViewController: UITableViewDelegate {
    
    /// Click action delegate of table view row.
    /// - Parameters:
    ///   - tableView: tableView object that displays news list
    ///   - indexPath: current indexpath object
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* navigating to NewsDetailsViewController Screen to display about news details */
        self.performSegue(withIdentifier: Segues.shared.DETAILS_IDENTIFIER, sender: newsListArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = newsListArray[sourceIndexPath.row]
        newsListArray.remove(at: sourceIndexPath.row)
        newsListArray.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            self.editPopup(indexPath: indexPath)
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            self.newsListArray.remove(at: indexPath.row)
            tableView.reloadData()
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }
    
    func editPopup(indexPath: IndexPath){
        
        var inputTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            //Do some other stuff
            
            if inputTextField?.text == "" {
                AlertManager.shared.showAlert("Enter Title")
            }
            else {
                self.newsListArray[indexPath.row].title = inputTextField?.text
                self.newsTableView.reloadData()
            }
            
        }
        actionSheetController.addAction(nextAction)
        //Add a text field
        actionSheetController.addTextField { textField -> Void in
            // you can use this text field
            inputTextField = textField
            inputTextField?.placeholder = "Enter Value"
            inputTextField?.text = self.newsListArray[indexPath.row].title
        }
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
}

