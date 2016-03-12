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
    // create object of REST Service handler
    var mRestServiceHandlerOfContentList : RestServiceHandler?
    
    // create object of content DBHandler
    var mContentListDBHandlerObj : ContentListDBHandler?
    
    // create object of Model Class
    var mModel = ContentListModel()

    // create an empty array to store content info data
    var mControllerContentInfoArray = [ContentInfo]()
    
    // create an empty arrat to store content view details data
    var mControllerContentViewsDetailsArray = [ContentView]()
    
    
    init()
    {
        // Test variable to show the status of the class to the compiler
        let mUnitTestVariale = false
        
        if (mUnitTestVariale)
        {
            // call ContentInfo data
            self.setDummyContentInfoController()
        
            // call ContentViewData method
            self.setDummyContentViewDetails()
        }
            
        else
        {
            // call the constructor of REST handler
            mRestServiceHandlerOfContentList = RestServiceHandler()
            
            // create object of restHandler's getJSonArray method
            let restObj = mRestServiceHandlerOfContentList!.getJSONArray()
            
            // get contentInfo data in the form of
            let contentInfoJSONArray : NSMutableArray = restObj.infoJSON
            
            // get the content list info data from json
            self.PopulateContentInfoData(contentInfoJSONArray)
            
            // get contentListView details from jSON
            let contentListViewJsonArray : NSMutableArray = restObj.viewJson
            
            // get the content list view deatails data from json 
            populateContentListDetails(contentListViewJsonArray)
        }
    }
    
    
    // set dummy contentInfo
    func setDummyContentInfoController ()
    {
        let controllerSetContentInfoObj1 = ContentInfo(mContentID: 5, mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")//ContentInfo(mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")
        
        mControllerContentInfoArray.append(controllerSetContentInfoObj1)
        
        let controllerSetContentInfoObj2 = ContentInfo(mContentID: 1, mConrollerContentTitle: "Bat", mControllerContentImagePath: "imagePath.jpeg")//ContentInfo(mConrollerContentTitle: "Ball", mControllerContentImagePath: "imagePath.jpeg")
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
    func PopulateContentInfoData(contentInfoJSONArray : NSMutableArray)
    {
        // set & get content info list model object
        for count in contentInfoJSONArray
        {
           let DictObj =  contentInfoDataListModel(JSONContentInfoElement: count as! NSDictionary)
            
            // set contentList controller's attributes
            let temObj = ContentInfo(mContentID: DictObj.mModelContentID, mConrollerContentTitle: DictObj.mModelContentTitle, mControllerContentImagePath: DictObj.mModelContentImagePath)
            
            // initiate database in content DB handler
            mContentListDBHandlerObj = ContentListDBHandler()
            
            // save the Content Info data in database
            
            // write a query to create Table data base
            let createTableQuery : String = "CREATE TABLE IF NOT EXISTS CONTENTLISTINFO (Content_ID INTEGER PRIMARY KEY , Content_Title TEXT, Content_ImagePath TEXT)"
            
            // write a query to insert content info data in database
            let insertDataQuery : String = "INSERT INTO CONTENTLISTINFO (Content_ID ,Content_Title,Content_ImagePath) VALUES('\(temObj.mContentID!)','\((temObj.mConrollerContentTitle)!)','\((temObj.mControllerContentImagePath)!)')"
            
            // pass these queries to DBHandler to save ContentInfoData
            mContentListDBHandlerObj?.saveContentListInfoData( createTableQuery, insertContentInfoQuery: insertDataQuery)
            
            // append this contentListInfo array
            mControllerContentInfoArray.append(temObj)
        }
    }
    
    //  populate model & get model object from controller
    func populateContentListDetails (contentViewJSONArray : NSMutableArray)
    {
        // set & get content list view details data model object
        for count in contentViewJSONArray
        {
            let DictObj = contentViewListDataModel(JSONContentInfoElement: count as! NSDictionary)
            
            // set contentList view controller's attributes
            let temObj = ContentView(mContentID: DictObj.mModelContentID, mControllerContentAction: DictObj.mModelContentAction, mControllerContentLastSeen: DictObj.mModelContentLastSeen, mControllerContentTotalViews: DictObj.mModelContentTotalViews, mControllerContentTotalParticipants: DictObj.mModelContentTotalParticipants)
            
            // initiate database in contentDB handler
            mContentListDBHandlerObj = ContentListDBHandler()
            
            // save the Content Info data in database
            
            // write a query to create Table data base
            let createTableQuery : String = "CREATE TABLE IF NOT EXISTS CONTENTLISTVIEWS (Content_ID INTEGER PRIMARY KEY , Content_Action TEXT, Content_LastSeen TEXT , Content_TotalViews INTEGER , Content_TotalParticipants INTEGER)"
            
            // write a query to insert content info data in database
            let insertDataQuery : String = "INSERT INTO CONTENTLISTVIEWS (Content_ID ,Content_Action,Content_LastSeen,Content_TotalViews,Content_TotalParticipants) VALUES(\(temObj.mContentID!),'\((temObj.mControllerContentAction)!)','\((temObj.mControllerContentLastSeen)!)' , \(temObj.mControllerContentTotalViews!) , \(temObj.mControllerContentTotalParticipants!) )"
            
            // pass these queries to DBHandler to save ContentInfoData
            mContentListDBHandlerObj?.saveContentListInfoData( createTableQuery, insertContentInfoQuery: insertDataQuery)
            
            // append this contentListInfo array
            mControllerContentViewsDetailsArray.append(temObj)
        }
    }
    
    // return contentInfo array & contentView array
    func getContentDataArrays (userID : Int) -> (ContentInfoArray : [ContentInfo] , ContentViewArray : [ContentView])
    {
        return (mControllerContentInfoArray , mControllerContentViewsDetailsArray)
    }
    
    
    

}
