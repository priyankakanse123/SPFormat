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
import SystemConfiguration



class Utility : UIViewController ,  MFMessageComposeViewControllerDelegate

{
    
     var localPathOfImage : NSURL = NSURL(fileURLWithPath: "defaultImage.jpg")
    
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
                    if(data != nil)
                    {
                        observer.next(UIImage(data : data!)!)
                        observer.success()
                    }
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
    
    // check net connectivity
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        
        print("zeroAddress",zeroAddress)
        
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress)
            {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }

    
    // This function dowload image in local path
    func downloadImage(urle : NSString) 
    {
        // Trimm white Space
        let urlTrim = urle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let urlStr : NSString = urlTrim.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let url = NSURL(string:urlStr as String)
        
        print("URL of source1",urlTrim)
        print("URL of sourcec3", url)
        
       
        
        // dowload Image To Local Path
        Alamofire.download(.GET, url!)
            {
                temporaryURL, response in
                
                // local path
                let fileManager = NSFileManager.defaultManager()
                //let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                
                
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                
                let pathComponent = response.suggestedFilename
                
                print("directoryURL",directoryURL.URLByAppendingPathComponent(pathComponent!))
                
                self.localPathOfImage = directoryURL.URLByAppendingPathComponent(pathComponent!)
                return directoryURL.URLByAppendingPathComponent(pathComponent!)
                
        }
        
    }
   
    
}
