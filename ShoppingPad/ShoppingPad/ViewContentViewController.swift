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


class ViewContentViewController: UIViewController //, UIPageViewControllerDataSource
{
//    // outlet of customize view
//    @IBOutlet weak var mCustomizeView: UIView!
//    
//    // declare content_ID variable
//    var mContent_ID : Int?
//    
//    // declare content_link variable
//    var mContentLink : String?
//    
//    // declare svgkImageView & initialize it with an empty object
//    var mContentImageView : SVGKFastImageView?
//    
//    // declare an imageView & initialize it with an empty imageView
//    //var mMediaImageView = UIImageView()
//    
//    // create an object of utility class
//    var mUtility : Utility?
//    
//    // create an object of viewContentViewModel
//    var mViewContentViewModel : ViewContentViewModel?
//    
//    // variable stores the index of an image
//    var mImageIndex : Int?
//    
//    // create an object of UIPageViewController
//     var pageViewController: UIPageViewController!
//    
//    // create an array of ViewContentViewModel objects
//    var mViewContentViewModelArray = [ViewContentStruct]()
//    
//    // create an object of Content View Controller
//    var vc : ContentViewController?
//    
//    // executes when screen gets load
//    override func viewDidLoad()
//    {
//       super.viewDidLoad()
//        
//        print("contentID" , mContent_ID)
//        print("contentLink" , mContentLink)
//        
//        // call viewModel & populate ViewContentViewController
//        mViewContentViewModel = ViewContentViewModel()
//        
//        // get all the objects of ViewModelObjects
//        mViewContentViewModelArray = mViewContentViewModel!.getViewContentData()
//        
//        //===============code for swiping
//        
//        
//        
//        // initialize pageVieController with its identifier
//        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewContentController") as! UIPageViewController
//        
//        // connect datasource of pageViewController to the self
//        self.pageViewController.dataSource = self
//       
//        // initialize VC with an default first svg image
//        let startVC = self.viewControllerAtIndex(0) as ContentViewController
//        
//        // create an array of ViewControllers which contains images
//        let viewControllers = NSArray(object: startVC)
//        
//        
//        self.pageViewController.setViewControllers(viewControllers as [AnyObject] as? [UIViewController], direction: .Forward, animated: true, completion: nil)
//        
//        
//        
//        self.pageViewController.view.frame = mCustomizeView.frame//CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
//        
//        
//        
//        self.addChildViewController(self.pageViewController)
//        
//        self.view.addSubview(self.pageViewController.view)
//        
//        self.pageViewController.didMoveToParentViewController(self)
//
//        
//    }
//    
//    func viewControllerAtIndex(index: Int) -> ContentViewController{
//        if ((self.mViewContentViewModelArray.count == 0) || (index >= self.mViewContentViewModelArray.count))
//        {
//            
//            return ContentViewController()
//            
//        }
//        
//        
//        
//        vc = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewContentController") as? ContentViewController
//        
//        
//        
//        vc!.imageFile = self.mViewContentViewModelArray[index].mContentPage
//        
//        //vc.titleText = self.pageTitles[index]as! String
//        
//        vc!.pageIndex = index
//        
//        
//        return vc!
//        
//        
//    }
//    
//    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
//        
//    {
//        
//        //let vc = viewController as! ContentViewController
//        
//        var index = vc!.pageIndex as Int
//        
//        if (index == 0 || index == NSNotFound)
//            
//        {
//            
//            return nil
//            
//        }
//        
//        index--
//        
//        return self.viewControllerAtIndex(index)
//        
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
//        
//        
//        //let vc = viewController as! ContentViewController
//        var index = (vc!.pageIndex) as Int
//        
//        if (index == NSNotFound){
//            return nil
//        }
//        
//        index++
//        
//        if (index == self.mViewContentViewModelArray.count){
//            return nil
//        }
//        
//        return self.viewControllerAtIndex(index)
//        
//    }
//
//
//
//    
//
//    
//    // send message click action
//    @IBAction func sendMessage(sender: AnyObject)
//    {
//        mUtility?.sendTextMessage()
//    }
//    
//    @IBAction func pagesButtonPressed(sender: AnyObject)
//    {
//        // set mImageIndex  to the default value
//        mImageIndex = 0
//        // create an array of view model
//        var pageArray = mViewContentViewModel!.getViewContentData()
//        
//        // set an svg image in the imageview
//        mContentImageView = SVGKFastImageView( SVGKImage: pageArray[0].mContentPage)
//        
//        print("image" , pageArray[mImageIndex!].mContentPage)
//        
//        // get images from view model
//        mContentImageView?.frame = mCustomizeView.frame
//        
//        mCustomizeView.addSubview(mContentImageView!)
//        
//    }
//    
    
    
}
