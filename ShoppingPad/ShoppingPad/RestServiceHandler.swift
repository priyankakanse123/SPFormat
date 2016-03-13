//
//  RestServiceHandler.swift
//  ShoppingPad
//
//  Purpose:
//  1)This is RestServiceHandler of MVVM design pattern
//  Handles all service calls to the server site
//  Referrence - Controller
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit


class RestServiceHandler {
    
    // declare unit test variable which tells the mode of the operation to the compiler
    let mUntiTest : Bool = false // change
    
    //declare an array 
    var sampleInfoArray = NSMutableArray ()
    
    // Rest URL string
    var URLStringContentInfo : String = "http://52.90.50.117:3046/api/v1/user_content_view"

    // Declare Json Info array
    var mJSONArrayInfo = NSMutableArray()
    
    // Declare Json Content array
    var mJSONArrayViews = NSMutableArray()
    
    init()
    {
        // check the status of the class by compiler whether the class is in test mode or not
       if (mUntiTest)
       {
            // call dummy data methods
            self.populateDummyContentInfoJson()
            self.populateDummyContentViewJson()
       }
        
       
    }
    
    
    // get content info JSON from server
    func populateViewDetailsData (contentListViewListener : PContentListListener)
    {
     // call the json from server
        var json : NSMutableArray?
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://52.90.50.117:3046/api/v1/content_info")!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    self.mJSONArrayViews = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                    // Access specific key with value of type String
                    let Dict = self.mJSONArrayViews [1]
                    print (Dict)
                    
                    // send call back to controller
                    contentListViewListener.updateControllerListModel(self.mJSONArrayViews)
                } catch {
                    // Something went wrong
                }
            }
        }).resume()
    }
    
    // populate content list info
    func populateContenInfoDta (ContentListInfoDataListener : PContentListListener)
    {
        // call the json from server
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://52.90.50.117:3046/api/v1/user_content_view")!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    self.mJSONArrayInfo = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                    
                    
                    // send call back to controller
                    ContentListInfoDataListener.updateControllerViewModel(self.mJSONArrayInfo)
                    
                } catch {
                    // Something went wrong
                }
            }
        }).resume()
    }

    // populate content info JSONArray with dummy data
    func populateDummyContentInfoJson ()
    {
        mJSONArrayInfo = [["Title" : "Ring" , "ContentID" : 1 , "ImagePath" : "imagePath.jpeg"] , ["Title" : "doll" , "ContentID" : 2 , "ImagePath" : "imagePath.jpeg"]]
    }
    
    // populate content view JSONArray with dummy data
    func populateDummyContentViewJson ()
    {
        mJSONArrayViews = [["ContentID" : 1 , "ContentAction" : "opened" , "TotalParticipants" : 23 , "TotalViews" : 24 , "LastSeen" : "5.19 pm"] , ["ContentID" : 2 , "ContentAction" : "clicked" , "TotalParticipants" : 19 , "TotalViews" : 20 , "LastSeen" : "2.39 pm"]]
    }
    
    func getJSONArray () -> (infoJSON : NSMutableArray , viewJson : NSMutableArray)
    {
        print("mJSONArrayInfo" , mJSONArrayInfo )
        print("mJSONArraycontentviews" , mJSONArrayViews)
        return (mJSONArrayInfo , mJSONArrayViews)
    }
}

    


