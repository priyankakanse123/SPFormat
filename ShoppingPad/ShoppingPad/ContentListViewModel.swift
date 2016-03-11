//
//  ContentListViewModel.swift
//  ShoppingPad
//
//  Purpose :
//  Extract the data needed for the ContentListUI from the local database via Controller class.
//  Referrence - Contrller Class
//  1)This class is viewModel of MVVM design pattern
//  2)It holds the model for the the contentListView
//  3)This class has the ContentListControllerObject to retrieve the necessary models
//  4)This class has attributes like content image , content title ,last view date time etc
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//



struct ContentViewModel {
    
    // Attributes of individual contentListModel
    var mContentImagePath : String? //image icon
    var mContentTitle : String?     //content title
    var mLastViewTime : String?     //last seen time
    var mActionPerformed : String?  //Action performed by the user
    var mTotalViews : Int?          //Total number of views
    var mTotalParticipants : Int?   //Total number of participants
    
}

class ContentListViewModel {
    
    // Object of ContentListViewController
    var mConteListControllerObj : ContentListViewController?
    
    //list of contentModels
    var mListOfContents = [ContentViewModel]()
    
    //UnitTest Variable
    var mTestVariable : Bool? = false
    
    //object of ContentListController
    var mContentListControllerObject : ContentListController?
    
    init()
    {
        //check whether contentListArray is empty or not
        if mListOfContents.count == 0
        {
            //check whether project is running in test mode or not
            if (mTestVariable == true)
            {
                print("populate dummy data")
                
                //call populateData method
                self.populateDummyData()
            }
            else
            {
                //populate data from controller
                populateContentListData()
            }

        }
    }
    
    
    //Populate contentInfoList with Data from controller
    func populateContentListData()
    {
        
        // init controller object
        mContentListControllerObject = ContentListController()
        
        // get all content data from controller
        let contentArray = mContentListControllerObject!.getContentDataArrays(0)
        
        // retrieve contentInfoArray from ContentArray (object)
        var contentInfoArray = contentArray.ContentInfoArray
        
        // retrieve contentViewArray from ContentArray (object)
        var contentViewArray = contentArray.ContentViewArray
        
        // for loop checking giving contentID of contentInfo array
        // where i stands for the index of contentInfoArray
        for var i = 0 ; i <  contentInfoArray.count; ++i
            {
                //for loop giving function of contentViewArray
                for var j = 0 ; j < contentViewArray.count ; ++j
                    {
                    // matching Content ID of contentInfoObject & contentViewObject
                      if (contentInfoArray[i].mContentID == contentViewArray[j].mContentID )
                        {
                           // set object of viewModel with the contentInfo & contentView values
                           let setObj = ContentViewModel(mContentImagePath: contentInfoArray[i].mControllerContentImagePath!, mContentTitle: contentInfoArray[i].mConrollerContentTitle!, mLastViewTime: contentViewArray[j].mControllerContentLastSeen!, mActionPerformed: contentViewArray[j].mControllerContentAction!, mTotalViews: contentViewArray[j].mControllerContentTotalViews!, mTotalParticipants: contentViewArray[j].mControllerContentTotalParticipants!)
                            
                            // append setObj in the listOfContents array
                            mListOfContents.append(setObj)
                        }
                }
        }
    }
    
    // populate dummy data when compiler is in unittestMode
    func populateDummyData()
    {
        // set a temp object to store ContentListObject attributes
        let setObj = ContentViewModel(mContentImagePath: "imagePath.jpeg", mContentTitle: "Bat", mLastViewTime: "9.23 pm", mActionPerformed: "opened", mTotalViews: 23, mTotalParticipants: 67)
        
        //Add the contentList object to  mListOfContents array
        mListOfContents.append(setObj)
        print(mListOfContents)
    }
    
    // return the object to the view class
    func getContentInfo (position : Int) -> ContentViewModel
    {
        print(mContentListControllerObject)
        return mListOfContents [position]
    }
    
    // return the total count of list of total contents
    func getContentInfoCount() -> Int
    {
        return mListOfContents.count
    }
    
    
}


    
    


    
   





