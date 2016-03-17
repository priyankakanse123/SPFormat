//
//  ContentListModel.swift
//  ShoppingPad
//
//  Purpose :
//  1)This is  ContentListModel of MVVM design pattern
//  Model contains contentList  data which is downloaded from backend
//  Referrence - Controller class
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

// Declaration of contentListInfo attributes
struct ModelContentListInfoAttributes
{
    var modelContentID : Int
    var modelContentTitle : String
    var modelContentImagePath : String
}

// Declaration if contentListViewDetails attributes
struct ModelContentListViewDetailsAttributes
{
    var modelContentID : Int
    var modelContentAction : String
    var modelContentLastSeen : String
    var modelContentTotalViews : Int
    var modelContentTotalParticipants : Int
}

class ContentListModel
{
    // declare modelContentInfo Array
    var mModelContentInfoArray = [ModelContentListInfoAttributes]()
    
    // declare modelContentViewDetails 
    var mModelContentViewDetailsArray = [ModelContentListViewDetailsAttributes]()
    
    // Populate Model Info array object with the help of jsonArray
    func populateInfoDataModel (contentInfoJSON : NSMutableArray)
    {
        //set model info objects
        for count in contentInfoJSON
        {
           
            // convert contentInfoJsonArray element into dictionary
            let countDict = count as! NSDictionary
             print("print " , Int(countDict.objectForKey("ContentID")! as! NSNumber))
            // set all info temporary object with all attributes
            let tempObj = ModelContentListInfoAttributes(modelContentID: Int(countDict.objectForKey("ContentID")! as! NSNumber), modelContentTitle: (countDict.objectForKey("Title")! as! String), modelContentImagePath: (countDict.objectForKey("ImagePath")! as! String))
            
            // append this object in contentInfo model
            mModelContentInfoArray.append(tempObj)
        }
    }
    
    // Populate Model view details with help of Json info array
    func populateViewDataModel(contentViewJSON : NSMutableArray)
    {
        // set model view object
        for count in contentViewJSON
        {
            // convert contentInfoJsonArray element into dictionary
            let countDict = count as! NSDictionary
            
            // set all view temporary objects with all attributes
            let tempObj = ModelContentListViewDetailsAttributes(modelContentID: Int(countDict.objectForKey("ContentID") as! NSNumber) , modelContentAction: countDict.objectForKey("ContentAction") as! String , modelContentLastSeen: (countDict.objectForKey("LastSeen") as! String), modelContentTotalViews: Int(countDict.objectForKey("TotalParticipants") as! NSNumber), modelContentTotalParticipants: Int(countDict.objectForKey("TotalViews") as! NSNumber))
            
            // append this object in contentView model
            mModelContentViewDetailsArray.append(tempObj)
            
        }
    }
    
    // return content data to the controller class
    func getModelContentListData() -> (modelInfo : [ModelContentListInfoAttributes] , modelView : [ ModelContentListViewDetailsAttributes] )
    {
      return (mModelContentInfoArray , mModelContentViewDetailsArray)
    }
}

// Declare Content info list data model
class contentInfoDataListModel
{
    var mModelContentID = Int()
    var mModelContentTitle = String()
    var mModelContentImagePath = String()
   
    // populate content list info data model from json dictionary
    init(JSONContentInfoElement : NSDictionary)
    {
        // set content list info model
        mModelContentID = Int(JSONContentInfoElement.objectForKey("content_id") as! NSNumber)
        //mModelContentImagePath = (JSONContentInfoElement.objectForKey("imagesLink")! as! String)
        mModelContentTitle = (JSONContentInfoElement.objectForKey("display_name")! as! String)
    }
}

// Declare content list view details data model
class contentViewListDataModel
{
    // declare all content list view model attributes
    var mModelContentID = Int()
    var mModelContentAction = String()
    var mModelContentLastSeen = String()
    var mModelContentTotalViews = Int()
    var mModelContentTotalParticipants = Int()
    
    // set all the contentInfo Model Data
    init(JSONContentViewElement : NSDictionary)
    {
        // set contents view details data model
        mModelContentID = Int(JSONContentViewElement.objectForKey("contentId") as! NSNumber)
        mModelContentAction = JSONContentViewElement.objectForKey("action") as! String
        //mModelContentLastSeen = JSONContentInfoElement.objectForKey("lastViewedDateTime") as! String
        mModelContentTotalParticipants = Int(JSONContentViewElement.objectForKey("numberOfViews") as! NSNumber)
        mModelContentTotalViews = Int(JSONContentViewElement.objectForKey("numberofparticipant") as! NSNumber)
    }
}

