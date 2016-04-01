//
//  ViewContentPageController.swift
//  ShoppingPad
//
//  Purpose : 
//  This class is used for swipping content Page images
//
//  Created by BridgeLabz on 31/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import SVGKit

class ViewContentPageController: UIViewController
{
    //  declare the status whether user clicked on pages or media
    var mPageStatus : Bool = true
    
    //  declare an imageView to show media images
    var mMediaImageView : UIImageView?
    
    // declare page imageview to show page images
    var mPageImageView : SVGKFastImageView?
    
    // declare an empty media image
    var mMediaImage : UIImage?
    
    // declare an empty page image
    var mPageImage : SVGKImage?
    
    // declare pageTitle 
    var mPageTitle : String?
    
    // declare page title label
    var mPageTitleLabel : UILabel?
    
    // page index
    var mPageIndex : Int?
    
    override func viewDidLoad()
    {
        // if user selects pages button
        if (mPageStatus == true)
        {
            // set frame of label title
            mPageTitleLabel = UILabel(frame: CGRect(x: 0, y: 50, width: (view.frame.width), height: 30))
            
            // set page title label label with page title string
            mPageTitleLabel?.text = mPageTitle
            
            // set page title alignment in the centre
            mPageTitleLabel?.textAlignment = NSTextAlignment.Center
            
            // add page title to the view
            view.addSubview(mPageTitleLabel!)
            
            // set frame of mPageImageView
            mPageImageView = SVGKFastImageView(frame: CGRect(x: 0 , y: 80 , width: view.frame.width, height: view.frame.height - view.frame.height - 80))
            
            // set image to the imageview
            mPageImageView = SVGKFastImageView(SVGKImage: mPageImage)
            
            // add image to the view
            view.addSubview(mPageImageView!)

        }
        
        else
        {
            // set frame of image view
            mMediaImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height))
            
            // set media image to the media image view
            mMediaImageView?.image = mMediaImage
            
            // add this media imageview in the view
            view.addSubview(mMediaImageView!)
        }
        
        
    }
    
    
    
}
