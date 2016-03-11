//
//  ContentListViewController.swift
//  ShoppingPad
//
//  Purpose : 
//  1)It is main UIClass & holds IBOutlet & IBActions of UI
//  2)It will listen to all UIActions
//  3)It implements observer pattern & change the state of vie
//  4)It holds the ContentListViewModel & inform the changes to the observer class
//  5)This is the View of MVVM design pattern
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ContentListViewController: UIViewController , ContentListViewObserver , UITableViewDataSource , UITableViewDelegate
{
    
    
    
    //? means either the value of viewModelObj is nil or intializing afterwords
    var mViewModelObj : ContentListViewModel?
    
    //contentListArray
    var mContentList = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call viewModel to populate the Data needed for UI
        mViewModelObj = ContentListViewModel()
        
        //Fetch the ContentListArray
        //var mContentList = mViewModelObj?.getContentInfo()
        
        // print the data fetching from viewmodel
        //print(mContentList![0].mContentImagePath!)
               
        
        }
    
    // Return number of sections in tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return number of rows in tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mViewModelObj!.getContentInfoCount()
    }
    
    // Set Cell values of the tableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //create object of customViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomViewCell") as! CustomViewCell
        
        //make imageView Round
        Utility().RoundImageView(cell.mContentCellImageView!)
        
        //fetch the cell object from View
        let cellObjectToDisplay = mViewModelObj!.getContentInfo(indexPath.row)
        
        // set content icon
        cell.mContentCellImageView.image = UIImage(named: (cellObjectToDisplay.mContentImagePath)!)
        
        // set content Title
        cell.mContentCellTitleLabel.text = cellObjectToDisplay.mContentTitle!
        
        // set content action
        cell.mContentCellViewAction.text = (cellObjectToDisplay.mActionPerformed!)
        
        // set total number of views of the content
        cell.mContentCellTotalViews.text = String(cellObjectToDisplay.mTotalViews!) + " views"
        
        // set total number of participants
        cell.mContentCellTotalParticipants.text = String(cellObjectToDisplay.mTotalParticipants!) + " participants"
        
        //set last seen of the content
        cell.mContentCellLastSeen.text = cellObjectToDisplay.mLastViewTime!
        
        return cell
        
    }
    
    // set tableViewCell height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // Create an AlertView
    func showAlerView(message : String )
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // Content Image Button
    @IBAction func mImageViewButtonPressed(sender: AnyObject)
    {
       self.showAlerView("ContentImage")
        
    }
    
    // ShareButton
    @IBAction func mShareButtonPressed(sender: AnyObject)
    {
        self.showAlerView("shareButtonPressed")
    }
    
    // Select tableView Row // Title Selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.showAlerView("Title Selected")
    }
    
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
