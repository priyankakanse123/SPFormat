//
//  ContentListController.swift
//  ShoppingPad
//  
//  Purpose:
//  1)This is the data controller in MVVM design pattern
//  2)Provides interface of view model to interact with controller. Abstracting Dataase layer , service layer and model layer.
//  3)Interacts with local DB to save contentList Data
//  4)Interacts with rest service handler to get cloud data
//  5)Encapsulating ContentInfo
//
//  Binds to contentListViewModel , DBHandler & RESTHandler. Used to perform Rest services arranging DBHandler Logic & manage contentListViewModel from local databasemodel 
//  Referrence - ViewModel & Model
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

struct ContentInfo
{
    //declaration of content information
    var mContentID : Int?
    var mConrollerContentTitle : String?
    var mControllerContentImagePath : String?
}

struct ContentView
{
    //declaration of Content view realated variable
    var mContentID : Int?
    var mControllerContentAction : String?
    var mControllerContentLastSeen : String?
    var mControllerContentTotalViews : Int?
    var mControllerContentTotalParticipants : Int?
}

class ContentListController
{
    var mControllerContentInfoArray = [ContentInfo]()
    var mControllerContentViewsDetailsArray = [ContentView]()
    
    init()
    {
        var mUnitTestVariale = true
        
        if (mUnitTestVariale)
        {
        // call ContentInfo data
        self.setDummyContentInfoController()
        
        // call ContentViewData method
        self.setDummyContentViewDetails()
        }
        else
        {
        
        }
    }
    
    
    // set dummy contentInfo
    func setDummyContentInfoController ()
    {
        let controllerSetContentInfoObj1 = ContentInfo(mContentID: 2, mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")//ContentInfo(mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")
        
        mControllerContentInfoArray.append(controllerSetContentInfoObj1)
        
        let controllerSetContentInfoObj2 = ContentInfo(mContentID: 1, mConrollerContentTitle: "Bat", mControllerContentImagePath: "imagePath.jpeg")//ContentInfo(mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")
        mControllerContentInfoArray.append(controllerSetContentInfoObj2)
        
    }
    
    //set dummy contentViewDetails
    func setDummyContentViewDetails ()
    {
        // set first dummy object
        let controllerSetContentViewDetailsObj1 = ContentView(mContentID: 1, mControllerContentAction: "opened", mControllerContentLastSeen: "9.33 pm", mControllerContentTotalViews: 23, mControllerContentTotalParticipants: 99)
        
        // add first dummy object
        mControllerContentViewsDetailsArray.append(controllerSetContentViewDetailsObj1)
        
        // set second dummy object
        let controllerSetContentViewDetailsObj2 = ContentView(mContentID: 2, mControllerContentAction: "clicked", mControllerContentLastSeen: "5.19 pm", mControllerContentTotalViews: 90, mControllerContentTotalParticipants: 78)
        
        // add second dummy object
        mControllerContentViewsDetailsArray.append(controllerSetContentViewDetailsObj2)
        
    }
    
    //Return count of an array
    func ReturnCountOfAnArray() -> Int
    {
        return mControllerContentInfoArray.count
    }
    
    
    //Populate data
    
    func PopulateContentInfo()
    {
        
    }
    
    func populateContentView()
    {
        
    }
    

    
    func getContentDetails(ContentID : Int) -> (ContentInfo : ContentInfo , ContentViw : ContentView)
    {
        var positionInfo : Int = 0
        var positionView : Int = 0
        var ContentCount : Int = self.ReturnCountOfAnArray()
        
        for var i = 0 ; i < ContentCount ; ++i
        {
            for var j = 0 ; j < ContentCount ; ++j
            {
              if ((ContentID ==  mControllerContentInfoArray[i].mContentID ) && (ContentID == mControllerContentViewsDetailsArray[j].mContentID ))
                {
                   positionInfo = i
                   positionView = j
                    break
                    
                }
            }
        }
        return (mControllerContentInfoArray[positionInfo] , mControllerContentViewsDetailsArray[positionView])
        
    }
    
        
//        while positionInfo < self.ReturnCountOfAnArray()
//        {
//            print("content ID in function" ,ContentID)
//            print("position in loop" , positionInfo)
//           print("contentId in loop" , mControllerContentInfoArray[positionInfo].mContentID!)
//            
//            if (ContentID ==  mControllerContentInfoArray[positionInfo].mContentID )//ContentID == mControllerContentViewsDetailsArray[position].mContentID )
//            {
//                print("Content ID" , ContentID )
//                print("postion in if" , positionInfo)
//                break
//            }
//           (positionInfo += 1)
//            
//        }
//        print("positionInfo" , positionInfo)
//        
//        while positionView < self.ReturnCountOfAnArray()
//        {
//            print("content ID in function" ,ContentID)
//            print("position in loop" , positionView)
//            print("contentId in loop" , mControllerContentInfoArray[positionView].mContentID!)
//            
//            if (ContentID ==  mControllerContentInfoArray[positionView].mContentID )//ContentID == mControllerContentViewsDetailsArray[position].mContentID )
//            {
//                print("Content ID" , ContentID )
//                print("postion in if" , positionInfo)
//                break
//            }
//            (positionView += 1)
//        }
//
//        
//        print("positionInfo" , positionInfo)
//        print("positionView" , positionView)
        
//        return (mControllerContentInfoArray[positionInfo] , mControllerContentViewsDetailsArray[positionView ])
//        
//    }
    

}
