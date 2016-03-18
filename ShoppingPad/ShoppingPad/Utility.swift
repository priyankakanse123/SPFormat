//
//  Utility.swift
//  ShoppingPad
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit

class Utility
{
    // make imageView round
    func RoundImageView (imageView : UIImageView)
    {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        
    }
    
    // call image from url
    func callImageURL(urlString : String) -> UIImage
    {
        // load image from url
        let myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:"https://upload.wikimedia.org/wikipedia/commons/6/61/Rainbow_Rose_%283366550029%29.jpg")!)!)
        
        return myImage!
    }
}
