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
                populateData()
            }

        }
    }
    
    
    //Populate contentInfoList with Data from controller
    func populateData()
    {
        
        // init controller object
        mContentListControllerObject = ContentListController()
        
        //get total count of contents from controller
        let totalCount = mContentListControllerObject!.ReturnCountOfAnArray()
        
        for ( var i = 1 ; i <= totalCount ; ++i )
        {
        
            // create object of contentInfoController
            let ContentInfoObj = mContentListControllerObject!.getContentDetails(i).ContentInfo
        
            //create object of contentViewDetails
            let ContentViewDetailsObj = mContentListControllerObject!.getContentDetails(i).ContentViw
        
            // set a temp object to store ContentListObject attributes
            let setObj = ContentViewModel(mContentImagePath: ContentInfoObj.mControllerContentImagePath!, mContentTitle: ContentInfoObj.mConrollerContentTitle!, mLastViewTime: ContentViewDetailsObj.mControllerContentLastSeen!, mActionPerformed: ContentViewDetailsObj.mControllerContentAction!, mTotalViews: ContentViewDetailsObj.mControllerContentTotalViews!, mTotalParticipants: ContentViewDetailsObj.mControllerContentTotalParticipants!)
            print(setObj)
        
        
            //Add the contentList object to  mListOfContents array
            mListOfContents.append(setObj)
            print(mListOfContents)
        }
        
        
    }
    
    func populateDummyData()
    {
        // set a temp object to store ContentListObject attributes
        let setObj = ContentViewModel(mContentImagePath: "imagePath.jpeg", mContentTitle: "Bat", mLastViewTime: "9.23 pm", mActionPerformed: "opened", mTotalViews: 23, mTotalParticipants: 67)
        print(setObj)
        
        
        //Add the contentList object to  mListOfContents array
        mListOfContents.append(setObj)
        print(mListOfContents)

    }
    
    func getContentInfo (position : Int) -> ContentViewModel
    {
        print(mContentListControllerObject)
        return mListOfContents [position]
    }
    
    func getContentInfoCount() -> Int
    {
        return mListOfContents.count
    }
    
    
}


    
    


    
   





