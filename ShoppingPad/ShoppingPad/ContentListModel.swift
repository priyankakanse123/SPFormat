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
        mModelContentImagePath = (JSONContentInfoElement.objectForKey("imagesLink")! as! String)
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
        mModelContentLastSeen = JSONContentViewElement.objectForKey("lastViewedDateTime") as! String
        mModelContentTotalParticipants = Int(JSONContentViewElement.objectForKey("numberOfViews") as! NSNumber)
        mModelContentTotalViews = Int(JSONContentViewElement.objectForKey("numberofparticipant") as! NSNumber)
    }
}

