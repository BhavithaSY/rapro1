//
//  addingCategoriesViewController.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 3/19/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit

class addingCategoriesViewController: UIViewController {
    var column1=String()
    var column2=String()
    var column3=String()
    var column4=String()
    var tasks=Int()
    var desc=String()
    var email=String()
    @IBOutlet weak var nameofCate: UITextField!
    
    @IBOutlet weak var des: UITextField!
    
    
    @IBOutlet weak var tasksnumb: UITextField!
    
    
    @IBOutlet weak var col1: UITextField!
    
    @IBOutlet weak var col2: UITextField!
    
    @IBOutlet weak var col3: UITextField!
    
    @IBOutlet weak var col4: UITextField!
    
    
    @IBAction func catnamecheck(_ sender: UITextField) {
        //check for empty text field and also non repeating name
    }
    
    
    
    @IBAction func saveaction(_ sender: UIButton) {
//        if(self.col1.text != "")
//        {
//            self.column1=self.col1.text!
//        }
//        if(self.col2.text != "")
//        {
//            self.column2=self.col2.text!
//        }
//        if(self.col3.text != "")
//        {
//            self.column3=self.col3.text!
//        }
//        if(self.col4.text != "")
//        {
//            self.column4=self.col4.text!
//        }
//        if(self.tasksnumb.text != "")
//        {
//            self.tasks=Int(self.tasksnumb.text!)!
//        }
        if(self.des.text != "")
        {
            self.desc=self.des.text!
        }
       //call inserting function from php
        let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/addCategory.php")! as URL)
        request.httpMethod="POST"
        let postString = "CName=\(nameofCate.text! as String)&Csubtitle=\(self.desc as String)&email=\(self.email)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error == nil
                
            {
                print("entered error is nil")
                DispatchQueue.main.async (execute: { () -> Void in
                    
                    do {
                        //get json result
                        print("entered do")
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        print(json)
                        //assign json to new var parsejson in secured way
                        guard let parseJson = json else{
                            print("error")
                            return
                        }
                        print(parseJson)
                        //get name from parseJson dictionary
                       // let username:String = parseJson["UserName"] as! String
                       // let email:String=parseJson["Email"]as! String
                        let status:String=parseJson["status"] as! String
                        //let firstlogin:String=parseJson["FirstTimeLogin"] as! String
                        //print(firstlogin)
                        //print("ans from php: \(email)")
                        //let loginstatus = String(describing: parseJson["flagging"]!)
                        //print(loginstatus)
                        
                        //if there is some user
                        
                        if status == "500"
                        {
                            
                           let alert:UIAlertController=UIAlertController(title:"ERROR",message:"Category name already exixts please enter new name",preferredStyle:.alert)
                            let ok=UIAlertAction(title:"OK",style:UIAlertActionStyle.cancel,handler:nil)
                            alert.addAction(ok)
                            //present on screen
                            self.present(alert,animated:true,completion:nil)
                            
                        }
                        
                        else if status == "200"{
                            
                            let alert:UIAlertController=UIAlertController(title:"ADDED",message:"Category successfully added",preferredStyle:.alert)
                            
                            let ok=UIAlertAction(title:"OK",style:UIAlertActionStyle.default){(_) in
                                
                                
                                self.dismiss(animated: true, completion: nil)
                                
                            }
                            alert.addAction(ok)
UserDefaults.standard.set(1, forKey: "addedcategory")
                         //present on screen
                            self.present(alert,animated:true,completion:nil)
                            //self.performSegue(withIdentifier: "loginSegue", sender: self)
                           // UserDefaults.standard.set(username, forKey: "UserName")
                           // UserDefaults.standard.set(email, forKey: "Email")
                           // UserDefaults.standard.set(firstlogin, forKey: "FirstTimeLogin")
                            //print("entered user name block")
                            //print("username: \(username)")
                        }
//                        else{
//                           // self.dummy.text="please enter valid username and password!!!"
//                            print("entered username is nil block")
//                        }
                        
                        
                        
                    }catch
                    {
                        print("error: \(error)")
                    }
                    //print("response = \(response)")
                    let responseString = NSString(data: data!,encoding:String.Encoding.utf8.rawValue)
                    print("response string = \(responseString!)")
                    
                })
                
                
            }
            else
            {
                //print("entered error is not nill")
                print("error=\(error)")
                //self.dummy.text=error as! String?
                return
            }
        }//task closing
        task.resume()

    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.column1="column1"
        self.column2="column2"
        self.column3="column3"
        self.column4="column4"
        self.tasks=4
        self.desc=" "
        self.email=UserDefaults.standard.string(forKey: "Email")!
        print(self.email)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationItem.title="ADD category"

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
