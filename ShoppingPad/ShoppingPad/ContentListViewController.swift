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
    
    // create object of utility class
    var mUtility = Utility()
    
    // crate variable saving content_id
    var mContent_id : Int?

    // create variable used to store content_link
    var mContentLink : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = true
        
        // start animating activity indicator
        mActivityIndicator.startAnimating()
        
        // Call viewModel to populate the Data needed for UI
        self.mViewModelObj = ContentListViewModel(contentListViewObserver: self)
        
        // initialize custom view cell with emty object
        mCustomCell = CustomViewCell()

        // define background thread
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            print("This is run on the background queue")
            
            // call the method populateModel method which is inside contentList
            self.mViewModelObj!.populateContentListData()
            
            self.bindData()

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
        
        //create object of customViewCell
        mCustomCell = tableView.dequeueReusableCellWithIdentifier("CustomViewCell") as? CustomViewCell
        
        //make imageView Round
        Utility().RoundImageView(mCustomCell!.mContentCellImageView!)
    
        //fetch the cell object from View
        let cellObjectToDisplay = mViewModelObj!.getContentInfo(indexPath.row)
        
        // load image from url
        //let cellImage = mUtility.callImageURL(cellObjectToDisplay.mContentImagePath.value)
        
        // set content icon
        //self.mCustomCell!.mContentCellImageView.image = cellImage
        
        // set content Title
        mCustomCell!.mContentCellTitleLabel.text = cellObjectToDisplay.mContentTitle.value
        
        // set content action
        mCustomCell!.mContentCellViewAction.text = (cellObjectToDisplay.mActionPerformed.value)
        
        // set total number of views of the content
        mCustomCell!.mContentCellTotalViews.text = String(cellObjectToDisplay.mTotalViews.value) + " views"
        
        // set total number of participants
        mCustomCell!.mContentCellTotalParticipants.text = String(cellObjectToDisplay.mTotalParticipants.value) + " participants"
        
        //set last seen of the content
       mCustomCell!.mContentCellLastSeen.text = cellObjectToDisplay.mLastViewTime.value
        
        return mCustomCell!
        
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
        mContent_id = cellObjectToDisplay.mContentID.value
        mContentLink = cellObjectToDisplay.mContentLink
        
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
            viewContentControllerObj.mContent_ID = mContent_id!
            viewContentControllerObj.mContentLink = mContentLink!
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // reload tableview 
    func updateContentListViewModel()
    {
        //self.loadView()
        print("count" , mViewModelObj!.getContentInfoCount())
        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            
            // reload tableView
            self.tableView.reloadData()
            
            // remove activity indicator
            self.mActivityIndicator.hidden = true

        }
    }
    
    // bind the data of view controller to view model
    func bindData()
    {
        mContentViewModel?.mContentTitle.bindTo(mCustomCell!.mContentCellTitleLabel)
        mContentViewModel?.mActionPerformed.bindTo(mCustomCell!.mContentCellViewAction)
        mContentViewModel?.mLastViewTime.bindTo(mCustomCell!.mContentCellLastSeen)
        
        
        mContentViewModel?.mTotalParticipants.bindTo(mCustomCell!.mContentCellTotalViews)
        mContentViewModel?.mTotalViews.bindTo(mCustomCell!.mContentCellTotalViews)
    }
}
