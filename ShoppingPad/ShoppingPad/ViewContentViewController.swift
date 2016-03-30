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
    
    // create a variable to store page title
    var mPageTitle : String?
    
    // button status media or page
    var mPage : Bool? = true
    
    // set first default page Image
    var mDefaultFirstPageImageView : SVGKFastImageView?
    
    // set first default media image
    var mDefultFirstMediaImgeView : UIImageView?
    
    
    // outlet of collection view
    @IBOutlet weak var mViewContentMediaCollectionView: UICollectionView!
    
    // executes when screen gets loaded
    override func viewDidLoad()
    {
        // initialize ViewContentViewModel
        mViewContentViewModelObj = ViewContentViewModel()
        
        self.PageButtonPressed(self)
    }
    
    
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
            // set the page imageview frame with default size
            var mSVGImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: (cell.frame.height - 50)))
        
            // set the pageImageview with actual pageImage
            mSVGImageView = SVGKFastImageView(SVGKImage: viewModelobj[indexPath.row].mContentPage)
            
            // add page imageview in the cell
            cell.contentView.addSubview(mSVGImageView)
            
//            // add the title label
//            let titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: cell.frame.height - 20, width: cell.frame.width, height: 20))
            
//            // set the page title
//            titleLabel.text = viewModelobj[indexPath.row].mPageTitle
//            
//            // add title label to the collection view cell
//            cell.contentView.addSubview(titleLabel)
            
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
        
        // get the data from view model
        let viewModelobj = mViewContentViewModelObj!.getViewContentData()

        // set first default imageView
        mDefaultFirstPageImageView = SVGKFastImageView(SVGKImage: viewModelobj[0].mContentPage)
        
        // add this to the view
        self.mViewContentMediaCollectionView.addSubview(mDefaultFirstPageImageView!)
        
        // reload collection view
        //mViewContentMediaCollectionView.reloadData()
    }
    
    // action taken after pressing media button
    
    @IBAction func mediaButtonPressed(sender: AnyObject)
    {
        // set flag to the false
        mPage = false
        
        // set default mediaimage
        mDefultFirstMediaImgeView = UIImageView(frame: mViewContentMediaCollectionView.frame)
        
        // set default image 
        mDefultFirstMediaImgeView?.image = UIImage(named: "imagePath.jpeg")
        
        // add this default image to the view
        view.addSubview(mDefultFirstMediaImgeView!)
    }
    
    @IBAction func showMoreImages(sender: AnyObject)
    {
        // hide default pageimageview
        mDefaultFirstPageImageView?.hidden = true
        
        // hide default imageview
        mDefaultFirstPageImageView?.hidden = true
        
        // reload collectionview
        mViewContentMediaCollectionView.reloadData()
    }
    
    
}
