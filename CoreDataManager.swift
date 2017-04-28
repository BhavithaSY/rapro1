//
//  CoreDataManager.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 1/29/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {
    
    //getting the context object
    private class func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    //storing the object
    class func storeObj(email:String,name:String,password:String)
    {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "UsersDetails", in: context)
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        managedObj.setValue(email, forKey: "email")
        managedObj.setValue(name, forKey: "userName")
        managedObj.setValue(password, forKey: "password")
        
        //saving the data in db
        do {
            try context.save()
            print("saved")
        } catch  {
            print(error.localizedDescription)
        }
    }
    //fetching the object
    class func fetchObj() -> [Users]
    {
      var aray=[Users]()
        
        let fetchRequest:NSFetchRequest<UsersDetails> = UsersDetails.fetchRequest()
        do {
           let fetchResult = try getContext().fetch(fetchRequest)
            //print(fetchResult)
            for item in fetchResult
            {
                let use = Users(email:item.email!,name:item.userName!,pass:item.password!)
                aray.append(use)
                print(use.username)
            }
        } catch  {
            
        }
        print("All users DEtails: \(aray)")
        
        return aray
        
    }
  //login request process
    class func loginreq(username:String,password:String) -> Bool
    {
        var flag:Bool=false
        var array=[Users]()
        
        if(username != "" && password != "")
        {
            
            let fetchRequest:NSFetchRequest<UsersDetails> = UsersDetails.fetchRequest()
            do {
                let fetchResult = try getContext().fetch(fetchRequest)
                //print(fetchResult)
                for item in fetchResult
                {
                    if (item.userName == username && item.password == password)
                    {
                    
                    flag=true
                        break
 
                    }
                    else
                    {
                        flag=false
                    }
                }
            } catch  {
                
            }

        }
        else{
            //should alert saying username and password can not be empty
        }
        return flag
    }
    
}
struct Users
{
    var username:String?
    var useremail:String?
    var userpass:String?
    
    init() {
        username=""
        useremail=""
        userpass=""
    }
    init(email:String,name:String,pass:String)
    {
        self.useremail=email
        self.username=name
        self.userpass=pass
    }
}
