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
    var mControllerContentLink : String?
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

class ContentListController : PContentListListener
{
    // create object of REST Service handler
    var mRestServiceHandlerOfContentList : RestServiceHandler?
    
    // create object of content DBHandler
    var mContentListDBHandlerObj : ContentListDBHandler?
    
    // protocol of view model
    var mContentViewModelListener : PContentListInformerToViewModel?
    
    // create an empty array to store content info data
    var mControllerContentInfoArray = [ContentInfo]()
    
    // create an empty arrat to store content view details data
    var mControllerContentViewsDetailsArray = [ContentView]()
    
    
    init(contentViewModelListener : PContentListInformerToViewModel)
    {
        // Test variable to show the status of the class to the compiler
        let mUnitTestVariale = false
        
        // call the constructor of REST handler
        mRestServiceHandlerOfContentList = RestServiceHandler()
        
        // call the constructor of model
         mContentListDBHandlerObj = ContentListDBHandler()
        
        if (mUnitTestVariale)
        {
            // call ContentInfo data
            self.setDummyContentInfoController()
        
            // call ContentViewData method
            self.setDummyContentViewDetails()
        }
        else
        {
            // set ContentViewModelListner protocols object
            mContentViewModelListener = contentViewModelListener
        }
    }
    
    
    // set dummy contentInfo
    func setDummyContentInfoController ()
    {
        let controllerSetContentInfoObj1 = ContentInfo(mContentID: 5, mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg" , mControllerContentLink: "http")
        
        mControllerContentInfoArray.append(controllerSetContentInfoObj1)
        
        let controllerSetContentInfoObj2 = ContentInfo(mContentID: 1, mConrollerContentTitle: "Bat", mControllerContentImagePath: "imagePath.jpeg" , mControllerContentLink: "http")//ContentInfo(mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")
        mControllerContentInfoArray.append(controllerSetContentInfoObj2)
        
    }
    
    // set dummy contentViewDetails
    func setDummyContentViewDetails ()
    {
        // set first dummy object
        let controllerSetContentViewDetailsObj1 = ContentView(mContentID: 1, mControllerContentAction: "opened", mControllerContentLastSeen: "9.33 pm", mControllerContentTotalViews: 23, mControllerContentTotalParticipants: 99)
        
        // add first dummy object
        mControllerContentViewsDetailsArray.append(controllerSetContentViewDetailsObj1)
        
        // set second dummy object
        let controllerSetContentViewDetailsObj2 = ContentView(mContentID: 5, mControllerContentAction: "clicked", mControllerContentLastSeen: "5.19 pm", mControllerContentTotalViews: 90, mControllerContentTotalParticipants: 78)
        
        // add second dummy object
        mControllerContentViewsDetailsArray.append(controllerSetContentViewDetailsObj2)
        
    }
    
    
    //  populate model & get model object from controller
    func PopulateContentInfoData()
    {
        // populate data in the rest
        mRestServiceHandlerOfContentList!.populateContenInfoDta(self)
    }

    
    // populate controllers data
    func populateContentInfoData(contentInfoJSONArray : NSMutableArray)
    {
        // set & get content info list model object
        for count in contentInfoJSONArray
        {
           let DictObj =  ContentInfoDataListModel(JSONContentInfoElement: count as! NSDictionary)
            
            // set contentList controller's attributes
            let temObj = ContentInfo(mContentID: DictObj.mModelContentID, mConrollerContentTitle: DictObj.mModelContentTitle, mControllerContentImagePath: DictObj.mModelContentImagePath , mControllerContentLink: DictObj.mModelContentLink)
            
            // save the Content Info data in database
            mContentListDBHandlerObj!.saveContentListInfoData(temObj.mContentID!, contentTitle: temObj.mConrollerContentTitle!, contentImagePath: temObj.mControllerContentImagePath!)
            
            // append this contentListInfo array
            mControllerContentInfoArray.append(temObj)
        }
    }
    
    //  populate model & get model object from controller
    func populateContentListDetails ()
    {
        // make rest call for content view details from json
        mRestServiceHandlerOfContentList!.populateViewDetailsData(self)

    }
    
    //  populate model & get model object from controller
    func populateContentListDetails (contentListViewJsonArray : NSMutableArray)
    {
        // set & get content list view details data model object
        for count in contentListViewJsonArray
        {
            let DictObj = ContentViewListDataModel(JSONContentViewElement: count as! NSDictionary)
            
            // set contentList view controller's attributes
            let temObj = ContentView(mContentID: DictObj.mModelContentID, mControllerContentAction: DictObj.mModelContentAction, mControllerContentLastSeen: DictObj.mModelContentLastSeen, mControllerContentTotalViews: DictObj.mModelContentTotalViews, mControllerContentTotalParticipants: DictObj.mModelContentTotalParticipants)
            
            
            // save the Content Info data in database
            mContentListDBHandlerObj!.saveContentListViewData(temObj.mContentID!, contentAction: temObj.mControllerContentAction!, contentLastSenn: temObj.mControllerContentLastSeen!, contentTotalViews: temObj.mControllerContentTotalViews!, contentTotalParticipants: temObj.mControllerContentTotalParticipants!)
            
            // append this contentListInfo array
            mControllerContentViewsDetailsArray.append(temObj)
        }
    }
    
    // return contentInfo array & contentView array
    func getContentDataArrays (userID : Int) -> (ContentInfoArray : [ContentInfo] , ContentViewArray : [ContentView])
    {
        return (mControllerContentInfoArray , mControllerContentViewsDetailsArray)
    }
    

   
   // implement protocol methods (callback)
    func updateControllerListModel(JsonContentInfo : NSMutableArray)
    {
        // populate content info method
        self.populateContentInfoData(JsonContentInfo)
        mContentViewModelListener!.updateViewModelContentListInformer()
    }
    
    // implement protocol method (call back)
    func updateControllerViewModel(JsonContentView : NSMutableArray)
    {
        // populate content view details method
        self.populateContentListDetails(JsonContentView)
        mContentViewModelListener!.updateViewModelContentListInformer()
    }
    
    
}
