//
//  Utility.swift
//  ShoppingPad
//
//  Purpose : 
//  Class contain functions of reusable codes
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


class Utility : ViewContentViewController, MFMessageComposeViewControllerDelegate

{
    
    var num : Bool = false
    // make imageView round
    func RoundImageView (imageView : UIImageView)
    {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        
    }
    
    // call image from within 5 seconds
    func callImageURL(urlString : String) -> UIImage
    {
        // define an image
        var contentImage : UIImage = UIImage(named: "defaultImage.jpg")!
        
        // convert String url to NSURL
        let url = NSURL(string: urlString)
        
        // if url exist
        if (url != nil)
        {
            // fetch the imageData from url
            let data = NSData(contentsOfURL: url!)
            
            // if image data exist
            if (data != nil)
            {
                // convert imagedata back to an image
                contentImage = UIImage(data: data!)!
            }
        }
            
        return contentImage
    }
    
    // send text message from the mobile phone
    
    func sendTextMessage ()
    {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["8652210204"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
            print("message sent")
        }
            
        else
        {
            print("can not send message")
        }
  
    }
    
    //... handle sms screen actions
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
   
    
}
