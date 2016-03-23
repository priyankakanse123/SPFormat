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


class ViewContentViewController: UIViewController
{
    // declare content_ID variable
    var mContent_ID : Int?
    
    // declare content_link variable
    var mContentLink : String?
    
    // performe actions when screen apperes
    override func viewDidLoad()
    {
       super.viewDidLoad()
        
        print("contentID" , mContent_ID)
        print("contentLink" , mContentLink)
        
    }
    
    
    
    // send message click action
    @IBAction func sendMessage(sender: AnyObject)
    {
    }
    
}
