//
//  showViewContent.swift
//  ShoppingPad
//
//  Created by BridgeLabz on 29/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import SVGKit

class ShowViewContent: UIViewController
{
    // current media image to show
    var mMediaImageToShow : UIImage?
    
    // current page Image to show
    var mPageImageToShow : SVGKImage?
    
    // current status of mode (i.e. Either media = true )
    var mPage : Bool?
    
    override func viewDidLoad()
    {
        if (mPage == true)
        {
            // set image to imageview
            let pageImageView = SVGKFastImageView(SVGKImage: mPageImageToShow)
            
            // set the frame of imageview
            pageImageView.frame = CGRectFromSVGRect(SVGRect(x: 0, y: 70, width: Float (view.frame.width), height: Float(view.frame.height - 100)))
            
            // add imageview to main view
            view.addSubview(pageImageView)
            
        }
        
        else
        {
            // set image to imageview
            let imageView = UIImageView(image: mMediaImageToShow)
            
            // set the frame of imageview
            imageView.frame = CGRectMake(0, 70, view.frame.width, view.frame.height - 100)
            
            // add imageview to main view
            view.addSubview(imageView)
 
        }
    }
    
    // back button pressed
    @IBAction func BackButtonPressed(sender: AnyObject)
    {
        // call the segue to go on the previous screen
        self.performSegueWithIdentifier("backToTheViewContent" , sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "backToTheViewContent"
        {
            //let viewContentVC = segue.destinationViewController as? ViewContentViewController
            
            //viewContentVC?.mPage = mPage
        }
    }
}
