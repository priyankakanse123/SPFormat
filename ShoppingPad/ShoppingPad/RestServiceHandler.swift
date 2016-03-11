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
    let mUntiTest : Bool = true
    
    //declare an array 
    var sampleInfoArray = NSMutableArray ()
    
    // Rest URL string
    var URLString : String = "http://52.90.50.117:3046/api/v1/user_content_view"
    
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
        
        // execute if the compiler is not in test mode
        else
       {
            // populate json from server
            self.populateViewDetailsData(URLString)
        }
    }
    
    
    // get JSON from server
    func populateViewDetailsData (URL : String)
    {
     // call the json from server
        
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
        return (mJSONArrayInfo , mJSONArrayViews)
    }
}

    


