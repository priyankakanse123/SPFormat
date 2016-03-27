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
import ReactiveKit
import ReactiveUIKit
import Alamofire


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
    
    // fetch image from server
    func fetchImage(url: NSURL) -> Operation<UIImage, NSError> {
        return Operation { observer in
            
            // use almofire to deal with server request
            let request = Alamofire.request(.GET, url).response { request, response, data, error in
                
                // if error occurs then abort the operation
                if let error = error {
                    observer.failure(error)
                } else {
                    // if doesnt occurs error then convert imageData back to image
                    observer.next(UIImage(data : data!)!)
                    observer.success()
                }
            }
            
            // if response is nil then execute this block
            return BlockDisposable {
                request.cancel()
            }
        }
    }
    
    // handle sms screen actions
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
   
    
}
