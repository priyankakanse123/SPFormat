//
//  ContentListViewController.swift
//  ShoppingPad
//
//  Purpose : 
//  1)It is main UIClass & holds IBOutlet & IBActions of UI
//  2)It will listen to all UIActions
//  3)It implements observer pattern & change the state of view
//  4)It holds the ContentListViewModel & inform the changes to the observer class
//  5)This is the Content List View of MVVM design pattern
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit
import Alamofire


class ContentListViewController: UIViewController , ContentListViewObserver , UITableViewDataSource , UITableViewDelegate
{
    // create outlet of of activity indicator
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    
    // outlet of tableview
    @IBOutlet weak var tableView: UITableView!
    
    //? means either the value of viewModelObj is nil or intializing afterwords
    // create object of ContentListViewModel object
    var mViewModelObj : ContentListViewModel?
    
    //define an empty array contentListArray
    var mContentList = NSArray()
    
    // create an empty object of custom cell
    var mCustomCell : CustomViewCell?
    
    // create an object of ContentViewModel Structure
    var mContentViewModel : ContentViewModel?

    // crate variable saving content_id
    var mContent_Id : Int?

    // initialize custom cell
    var customCell : CustomViewCell?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // start animating activity indicator
        mActivityIndicator.startAnimating()
        
        // Call viewModel to populate the Data needed for UI
        self.mViewModelObj = ContentListViewModel(contentListViewObserver: self)
        
        // initialize custom view cell with emty object
        mCustomCell = CustomViewCell()

        // define background thread
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue,
            {
                print("This is run on the background queue")
            
                // call the method populateModel method which is inside contentList
                self.mViewModelObj!.populateContentListData()
            
            })
    }
    
    // Return number of sections in tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    // Return number of rows in tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mViewModelObj!.getContentInfoCount()
    }
    
    // Set Cell values of the tableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       
        //var customCell : CustomViewCell = CustomViewCell()
        //fetch the cell object from View
        let cellObjectToDisplay = mViewModelObj!.getContentInfo(indexPath.row)
        
        //create object of customViewCell
        let tableCell = tableView.cellForRowAtIndexPath(indexPath)
        //var customCell : CustomViewCell = (tableView.cellForRowAtIndexPath(indexPath) as? CustomViewCell)!
        
        if (tableCell == nil)
        {
            print("not null")
            customCell = (tableView.dequeueReusableCellWithIdentifier("CustomViewCell") as?
                CustomViewCell)!
            Utility().RoundImageView(customCell!.mContentCellImageView)
            customCell!.mContentCellImageView.image = UIImage(named: "defaultImage.jpg")
            self.bindData(customCell!, contentViewModelObj: cellObjectToDisplay)

        }

        return customCell!
        
    }
    
    // set tableViewCell height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
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
        
        let cellObjectToDisplay = mViewModelObj!.getContentInfo(indexPath.row)
        
        // set the parameter of the contents
        mContent_Id = cellObjectToDisplay.mContentID.value
        
        // call the segue to open view content screen
        self.performSegueWithIdentifier("showViewContent", sender: nil)
    }
    
    
    // send data through segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "showViewContent")
        {
            // create object of view content controller
            let viewContentControllerObj = segue.destinationViewController as! ViewContentViewController
            
            // pass content link & content_id to view content controller
            viewContentControllerObj.mContentID = mContent_Id
        }
    }
    
    // reload tableview 
    func updateContentListViewModel()
    {
        //self.loadView()
        print("count" , mViewModelObj!.getContentInfoCount())
        
        dispatch_async(dispatch_get_main_queue())
        { [unowned self] in
            
            // reload tableView
            self.tableView.reloadData()
            
            // remove activity indicator
            self.mActivityIndicator.hidden = true
            
        }
    }
    
    // bind the data of view controller to view model
    func bindData(customCellObj : CustomViewCell , contentViewModelObj : ContentViewModel)
    {
        // bind content image
        let url = NSURL(string: contentViewModelObj.mContentImagePath.value)
        if (url != nil)
        {
            let image : ObservableBuffer<UIImage>? = Utility().fetchImage(url!).shareNext()
            if ((image) != nil)
            {
                image!.bindTo(customCellObj.mContentCellImageView)
            }
        }
        
        // bind content title
        contentViewModelObj.mContentTitle.bindTo(customCellObj.mContentCellTitleLabel)
        
        // bind content Action
        contentViewModelObj.mActionPerformed.bindTo(customCellObj.mContentCellViewAction)
        
        // bind content last seen
        contentViewModelObj.mLastViewTime.bindTo(customCellObj.mContentCellLastSeen)
        
        // bind content total participants data
        contentViewModelObj.mTotalParticipants.bindTo(customCellObj.mContentCellTotalParticipants)
        
        // bind total views data
        contentViewModelObj.mTotalViews.bindTo(customCellObj.mContentCellTotalViews)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
