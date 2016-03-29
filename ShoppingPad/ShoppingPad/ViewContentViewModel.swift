//
//  ViewContentViewModel.swift
//  ShoppingPad
//
//  Purpose :
//  This is view Model class of MVVM pattern
//  This is view model of viewContent class
//  This class contains object of view Content Controller
//  This class provides the data model to the viewContent view class
//
//  Created by BridgeLabz on 25/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import SVGKit

struct ViewContentStruct
{
    var mContentPage : SVGKImage        // store page images in .svg format
    var mMediaImage : UIImage           // store media images in .png model
}

class ViewContentViewModel
{
    // object of view content controller
    var mViewContentController : ViewContentController?
    
    // array of View Content Struct objects
    var mViewContentStructArray = [ViewContentStruct]()
    
    // define class test variable
    var mTestVariable :Bool =  true
    
    // initialize this class
    init()
    {
        // check whether compiler is in test mode or not
        if (mTestVariable == true)
        {
            self.dummyPopulateViewContentData()
        }
    }
    
    func dummyPopulateViewContentData()
    {
        // initialize first dummy object
        let firstObj = ViewContentStruct(mContentPage: SVGKImage(named: "page_2.svg"), mMediaImage: UIImage(named: "imagePath.jpeg")!)
        
        // initialize second dummy object
        let secondObj = ViewContentStruct(mContentPage: SVGKImage(named: "page_6.svg"), mMediaImage: UIImage(named: "m_10839690492099.png")!)
        
        // append first object
        mViewContentStructArray.append(firstObj)
        
        // append second object
        mViewContentStructArray.append(secondObj)
    }
    
    func getViewContentData() -> [ViewContentStruct]
    {
       return mViewContentStructArray
    }
    

}
