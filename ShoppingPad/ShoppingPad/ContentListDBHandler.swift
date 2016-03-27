//
//  ContentListDBHandler.swift
//  ShoppingPad
//
//  Purpose:
//  1)This is DBHandler of MVVM design pattern
//  Manages all the data needed for the contentList class in Local DB
//  Refference - Controller
//
//  Created by BridgeLabz on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ContentListDBHandler {
    
    var mDatabasePath : String
    
    // create database
    init()
    {
        // create default database path
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        mDatabasePath = docsDir.stringByAppendingPathComponent(
            "ContentDB.sqlite")
        
        // if database path not exist create new database
        if !filemgr.fileExistsAtPath(mDatabasePath as String)
        {
            // create database
            let DB = FMDatabase(path: mDatabasePath as String)
            print("path ", DB)
            
            // if some error occurs pront error message
            if DB == nil
            {
                print("Error: \(DB.lastErrorMessage())")
                
            }
        }
    }
    
    // save the data into the database
    func saveData(createTableQuery : String , insertContentInfoQuery : String)
    {
        let contentDB = FMDatabase(path : mDatabasePath as String)
        print("database Path" , mDatabasePath)
        
        // Check whether database is open or not
        if contentDB.open()
        {
            // execute create table query
            let result = contentDB.executeUpdate(createTableQuery, withArgumentsInArray: nil)
            
            // check whether query executed succesfully or not
            if !result
            {
                print("Error: \(contentDB.lastErrorMessage())")
            }
                
            else
            {
               print("executed")
            }
            
            // insert query
            let insertContentQuery = insertContentInfoQuery
            
            let resultContent = contentDB.executeUpdate(insertContentQuery, withArgumentsInArray: nil)
            
            // check whether query executed succesfully or not
            if !resultContent
            {
                print("Error: \(contentDB.lastErrorMessage())")
            }
                
            else
            {
               print("executed insert")
                
            }
        
        }
            
        
        else
        {
            print("Error: \(contentDB.lastErrorMessage())")
        }
        
    }
    
    // save contentList info data in the table 
    func saveContentListInfoData(contentID : Int , contentTitle : String , contentImagePath : String , contentLink : String , contentType : String , contentCreatedTime : String , contentDescription : String , contentModifiedAt : String ,contentSyncDateTime : String , contentTitleName : String , contentURL : String , contentZipPath : String)
    {
        // write a query to check whether table exist or not and if not then create a table
        let createTableQuery : String = "CREATE TABLE IF NOT EXISTS CONTENTLISTINFO (Content_ID INTEGER PRIMARY KEY , Content_Title TEXT, Content_ImagePath TEXT , Content_Link TEXT , Content_Type TEXT , Content_CreatedTime TEXT , Content_Description TEXT , Content_ModifiedTime TEXT , Content_SyncDateTime TEXT , Content_TitleName TEXT , Content_URL TEXT , Content_ZipPath TEXT)"
        
        // write a query to insert content info data in database
        let insertDataQuery : String = "INSERT INTO CONTENTLISTINFO (Content_ID ,Content_Title,Content_ImagePath , Content_Link ,  Content_Type , Content_CreatedTime , Content_Description , Content_ModifiedTime , Content_SyncDateTime , Content_TitleName , Content_URL , Content_ZipPath) VALUES('\(contentID)','\((contentTitle))','\((contentImagePath))' , '\((contentLink))' , '\((contentType))' , '\((contentCreatedTime))' , '\((contentDescription))' , '\((contentModifiedAt))' , '\((contentSyncDateTime))' , '\((contentTitleName))' , '\((contentURL))' , '\((contentZipPath))')"
        
        // save the database in local database
        self.saveData(createTableQuery, insertContentInfoQuery: insertDataQuery)
        

    }
    
    func saveContentListViewData(contentID : Int , contentAction : String , contentLastSenn : String , contentTotalViews : Int , contentTotalParticipants : Int , displayProfile : String , emailId : String , firstName : String , lastName : String , lastViewDateTime : String , userAdminID : Int , userContentID : Int , userID : Int)
    {
        
        // write a query to create a table
        let createTableQuery : String = "CREATE TABLE IF NOT EXISTS CONTENTLISTVIEWS (Content_ID INTEGER PRIMARY KEY , Content_Action TEXT, Content_LastSeen TEXT , Content_TotalViews INTEGER , Content_TotalParticipants INTEGER , Display_Profile TEXT , Email_ID TEXT , FirstName TEXT , LastName TEXT , LastViewDateTime TEXT , UserAdmin_ID INTEGER , UserContent_ID INTEGER , User_ID INTEGER , UserID INTEGER )"
        
        // write a query to insert content info data in database
        let insertDataQuery : String = "INSERT INTO CONTENTLISTVIEWS (Content_ID ,Content_Action,Content_LastSeen,Content_TotalViews,Content_TotalParticipants , Display_Profile , Email_ID , FirstName , LastName , LastViewDateTime , UserAdmin_ID , UserContent_ID , UserID ) VALUES(\(contentID),'\((contentAction))','\((contentLastSenn))' , \(contentTotalViews) , \(contentTotalParticipants) , '\((displayProfile))' , '\((emailId))' , '\((firstName))' , '\((lastName))' , '\((lastViewDateTime))' , \(userAdminID) , \(userContentID) , \(userID))"
        
        // save the data in local database
        self.saveData(createTableQuery, insertContentInfoQuery: insertDataQuery)
    }
}