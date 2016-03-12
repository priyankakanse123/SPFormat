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
    func saveContentListInfoData(createTableQuery : String , insertContentInfoQuery : String)
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
    

}
