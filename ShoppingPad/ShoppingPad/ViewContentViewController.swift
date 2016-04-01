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


class ViewContentViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UIPageViewControllerDataSource
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
    //var mDefaultFirstPageImageView : SVGKFastImageView?
    
    // set first default media image
    //var mDefultFirstMediaImgeView : UIImageView?
    
    // object of pageview controller
    var mPageViewController : UIPageViewController?
    
    // declare an array of objects coming from view model
    var mViewModelObjArray = [ViewContentStruct]()
    
    // outlet of collection view
    @IBOutlet weak var mViewContentMediaCollectionView: UICollectionView!
    
    // executes when screen gets loaded
    override func viewDidLoad()
    {
        // initialize ViewContentViewModel
        mViewContentViewModelObj = ViewContentViewModel()
        
        //initialize page view controller with view controller identifiew
        self.mPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        
        // set page view controller data source to the self
        self.mPageViewController!.dataSource = self
        
        // initialize starting view controller
        let startVC = self.viewControllerAtIndex(0) as ViewContentPageController
        
        // initialize an array of view controllers
        let viewControllers = NSArray(object: startVC)
        
        // enable animation in the view controller
        self.mPageViewController!.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        // set the frame of view controller
        self.mPageViewController!.view.frame = CGRectMake(0, 108, self.view.frame.width, self.view.frame.size.height - 120)
        
        // add the page view controller inside the main view controller
        self.addChildViewController(self.mPageViewController!)
        
        // add the page view inside the view
        self.view.addSubview(self.mPageViewController!.view)
        
        //
        self.mPageViewController!.didMoveToParentViewController(self)
    }
    
    // function returns current view controller
    func viewControllerAtIndex(index: Int) -> ViewContentPageController
    {
        // populate the data from view model
        self.arrayOfViewModelObjects()
        
        
        // check whether arry count is empty or bigger than the total count
        if ((self.mViewModelObjArray.count == 0) || (index >= self.mViewModelObjArray.count))
        {
            // return empty vc
            return ViewContentPageController()
        }
        
        // create object of ViewContentPageController
        let vc: ViewContentPageController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ViewContentPageController
        
        if (mPage == true)
        {
            // populate ViewContentPageController with actual values
            vc.mPageIndex = index
            vc.mPageTitle = mViewModelObjArray[index].mPageTitle
            vc.mPageImage = mViewModelObjArray[index].mContentPage
            
        }
        
        else
        {
            vc.mPageIndex = index
            vc.mPageStatus = mPage!
            vc.mMediaImage = mViewModelObjArray[index].mMediaImage
            
        }
        
        
        // return the ViewContentPageController object
        return vc
    }
    
    // MARK: - Page View Controller Data Source
    
    // calls when user swipes to the right
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        // create object of ViewContentPageController
        let vc = viewController as! ViewContentPageController
        
        // variable stores current page index value
        var index = vc.mPageIndex! as Int
        
        // set page status
        vc.mPageStatus = mPage!
        
        // if index number is 0 or index number not found
        if (index == 0 || index == NSNotFound)
        {
            // return nil value
            return nil
        }
        
        // decrese the index number by 1
        index--
        
        // call the method viewControllerAtIndex
        return self.viewControllerAtIndex(index)
        
    }
    
    // call this method when user swipes left
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        // create object of ViewContentPageController
        let vc = viewController as! ViewContentPageController
        
        // variable stores current page index value
        var index = vc.mPageIndex! as Int
        
        // if index number is 0 or index number not found
        if (index == NSNotFound)
        {
            // return nil
            return nil
        }
        
        // increase index number by one
        index++
        
        // check whether index number is equal to total aray object count
        if (index == self.mViewModelObjArray.count)
        {
            // return nil
            return nil
        }
        
        // call the viewControllerAtIndex method
        return self.viewControllerAtIndex(index)
        
    }
    
    // get the data from view content view model
    func arrayOfViewModelObjects ()
    {
        // call the get content method from view model
        mViewModelObjArray = (mViewContentViewModelObj?.getViewContentData())!

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
            var mSVGImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: (cell.frame.height)))

            // set the pageImageview with actual pageImage
            mSVGImageView = SVGKFastImageView(SVGKImage: viewModelobj[indexPath.row].mContentPage)
            
            
            // add page imageview in the cell
            cell.contentView.addSubview(mSVGImageView)
            
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
        self.arrayOfViewModelObjects()
        
        self.callDefaultImage(indexPath.row)
//        let CurrentVC = self.viewControllerAtIndex(indexPath.row) as ViewContentPageController
//        let viewControllers = NSArray(object: CurrentVC)
//        
//        self.mPageViewController!.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
//        
//        self.mPageViewController!.view.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.size.height - 80)
//        
//        self.addChildViewController(self.mPageViewController!)
//        self.view.addSubview(self.mPageViewController!.view)
//        self.mPageViewController!.didMoveToParentViewController(self)
//        // get the image data from view model
//        let viewModelobj = mViewContentViewModelObj!.getViewContentData()
//        
//        // set the current media image
//        mCurrentMediaImage = viewModelobj[indexPath.row].mMediaImage
//        
//        // set the current svg image
//        mCurrentPageImage = viewModelobj[indexPath.row].mContentPage
//        
//        // call the segue method to enter in the next screen
//        performSegueWithIdentifier("showImage", sender: self)
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
        
        self.arrayOfViewModelObjects()
        
        self.callDefaultImage(0)
        
        //self.callDefaultImage(0)
//        // get the data from view model
//        let viewModelobj = mViewContentViewModelObj!.getViewContentData()
//
//        // set first default imageView
//        //mDefaultFirstPageImageView = SVGKFastImageView(SVGKImage: viewModelobj[0].mContentPage)
//        
//        // add this to the view
//        //self.mViewContentMediaCollectionView.addSubview(mDefaultFirstPageImageView!)
//        
//        // reload collection view
//        //mViewContentMediaCollectionView.reloadData()
    }
    
    // action taken after pressing media button
    
    @IBAction func mediaButtonPressed(sender: AnyObject)
    {
        // set flag to the false
        mPage = false
        
        // get the view model data
        self.arrayOfViewModelObjects()
        
        // call the default media image
        self.callDefaultImage(0)
        
    }
    
    // load collection view
    @IBAction func showMoreImages(sender: AnyObject)
    {
        // hide page view controller
        mPageViewController?.view.removeFromSuperview()
        
        // reload collectionview
        mViewContentMediaCollectionView.reloadData()
    }
    
    // call the default image
    func callDefaultImage(position : Int)
    {
        let CurrentVC = self.viewControllerAtIndex(position) as ViewContentPageController
        let viewControllers = NSArray(object: CurrentVC)
        
        self.mPageViewController?.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.mPageViewController?.view.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.size.height - 80)
        
        self.addChildViewController(self.mPageViewController!)
        self.view.addSubview(self.mPageViewController!.view)
        self.mPageViewController!.didMoveToParentViewController(self)
    }
    
}
