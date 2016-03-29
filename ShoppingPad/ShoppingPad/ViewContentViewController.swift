//
//  ViewContentViewController.swift
//  ShoppingPad
//
//  Purpose :
//  1)It is main UIClass & holds IBOutlet & IBActions of UI
//  2)It will listen to all UIActions
//  3)It implements observer pattern & change the state of view
//  4)It holds the ContentListViewModel & inform the changes to the observer class
//  5)This is the Content List View of MVVM design pattern
//
//  Created by BridgeLabz on 21/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import SVGKit


class ViewContentViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate
{
    // variable use to store contentID
    var mContentID : Int?
    // object of ViewContentViewModel 
    var mViewContentViewModelObj : ViewContentViewModel?
    
    // create variable to store current media image
    var mCurrentMediaImage : UIImage?
    
    // create a variable to store current page image
    var mCurrentPageImage : SVGKImage?
    
    // button status media or page
    var mPage : Bool? = true
    
    // executes when screen gets loaded
    override func viewDidLoad()
    {
        // initialize ViewContentViewModel 
        mViewContentViewModelObj = ViewContentViewModel()
        
        print("contentid" , mContentID)
    }
    
    // outlet of collection view
    @IBOutlet weak var mViewContentMediaCollectionView: UICollectionView!
    
    // method returns number of total sections in the collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    // method returns total numbers of items in a section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return mViewContentViewModelObj!.getViewContentData().count
    }
    
    // set the values to the collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        // intialize collection cell with media collection cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mediaCell", forIndexPath: indexPath) as! ViewContentMediaCollectionCell
        
        // get the data from view model
        let viewModelobj = mViewContentViewModelObj!.getViewContentData()
        
        // if media button pressed
        if (mPage == true)
        {
            // initialize a page imageview with default page image
            var mSVGImageView = SVGKFastImageView(SVGKImage: SVGKImage(named: "page_2.svg"))
        
            // set the page imageview frame with default size
            mSVGImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        
            // set the pageImageview with actual pageImage
            mSVGImageView = SVGKFastImageView(SVGKImage: viewModelobj[indexPath.row].mContentPage)
        
            
            // add page imageview in the cell
            cell.contentView.addSubview(mSVGImageView)
            
            // return the cell
            return cell

            
        }
        
        // if media button pressed
        else
        {
            // create imageview
            let mMediaImageView = UIImageView(image: UIImage(named: "imagePath.jpeg"))
            
            // set frame of imageview
            mMediaImageView.frame = CGRectMake(0, 0, cell.frame.width, cell.frame.height)
            
            // set image in the imageview
            mMediaImageView.image = viewModelobj[indexPath.row].mMediaImage
            
            // set the full image in the imageview
            mMediaImageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            // add the imageview in the collection view cell
            cell.contentView.addSubview(mMediaImageView)
            
            // return the cell
            return cell

        }
    }
    
    // executes when a user selects particular collection view cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        // get the image data from view model
        let viewModelobj = mViewContentViewModelObj!.getViewContentData()
        
        // set the current media image
        mCurrentMediaImage = viewModelobj[indexPath.row].mMediaImage
        
        // set the current svg image
        mCurrentPageImage = viewModelobj[indexPath.row].mContentPage
        
        // call the segue method to enter in the next screen
        performSegueWithIdentifier("showImage", sender: self)
    }
    
    // pass the imageData through swift
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // verify segue identifier
        if (segue.identifier == "showImage")
        {
            // object of ShowViewContent
            let ContentImageVC = segue.destinationViewController as? ShowViewContent
            
            // set the media image value to the showContentImage class
            ContentImageVC?.mMediaImageToShow = mCurrentMediaImage
            
            // set the page image to show contentImage class
            ContentImageVC?.mPageImageToShow = mCurrentPageImage
            
            // set the current status of the collection view
            ContentImageVC?.mPage = mPage
        }
    }
    
    // action taken after pressing pages button
    @IBAction func PageButtonPressed(sender: AnyObject)
    {
        // set the flag of mPage
        mPage = true
        
        // reload collection view
        mViewContentMediaCollectionView.reloadData()
    }
    
    // action taken after pressing media button
    
    @IBAction func mediaButtonPressed(sender: AnyObject)
    {
        // set flag to the false
        mPage = false
        
        // reload collection view
        mViewContentMediaCollectionView.reloadData()
    }
    
}
