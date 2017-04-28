//
//  ViewController.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 1/28/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit
extension UIImage{
    
    func alpha(value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var viewfor: UIView!
    
    @IBOutlet weak var usernameLogin: UITextField!
    
    @IBOutlet weak var viewforsignup: UIView!
    
    @IBOutlet weak var usernamesignup: UITextField!
    
    @IBOutlet weak var passwordsignup: UITextField!
    
    @IBOutlet weak var emailSignUp: UITextField!
    
    @IBOutlet weak var passwordLogin: UITextField!
    
    @IBOutlet weak var dummy: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //user defaults
//        let launchedBefore=UserDefaults.standard.bool(forKey: "launchedBefore")
//        if launchedBefore
//        {
//            print("launched before")
//        }
//        else
//        {
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//        }
//        
        
        
        
        
        
        
        
        //let the device in land scape mode
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        // Do any additional setup after loading the view, typically from a nib.
        
        //adjustin img , setting apla and setting as background
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "data-collection-data-termina")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            
            let imgg=image.alpha(value: 0.65)
            self.view.backgroundColor = UIColor(patternImage: imgg)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
            passwordsignup.isSecureTextEntry=true
            
        }
      
        
        
        
        
        viewfor.backgroundColor = UIColor(patternImage: UIImage(named:"bkgd")!)
       // usernameLogin.backgroundColor=UIColor.clear
        viewforsignup.backgroundColor=UIColor(patternImage: UIImage(named:"bkgd")!)
        viewforsignup.isHidden=true
        //CoreDataManager.fetchObj()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
            }
    
//let the device open in landscape mode
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    private func shouldAutorotate() -> Bool {
        return true
    }
    
    //
    
    @IBAction func gotoSignuppage(_ sender: Any) {
        
        viewforsignup.isHidden=false
        viewfor.isHidden=true
    }
    
    //
    @IBAction func gotologinpage(_ sender: Any) {
        viewforsignup.isHidden=true
        viewfor.isHidden=false
    }
    //signupbutton
    @IBAction func signUP(_ sender: Any) {
        //if the fields are empty
        if((usernamesignup.text?.isEmpty)! && (passwordsignup.text?.isEmpty)! && (emailSignUp.text?.isEmpty)!)
        {
            //make 3 red
            usernamesignup.attributedPlaceholder=NSAttributedString(string: "userName", attributes: [NSForegroundColorAttributeName:UIColor.red])
            emailSignUp.attributedPlaceholder=NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.red])
            passwordsignup.attributedPlaceholder=NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.red])
        }
            
        else if((usernamesignup.text?.isEmpty)! && !(emailSignUp.text?.isEmpty)! && !(passwordsignup.text?.isEmpty)!)
        {
            //make username red
            usernamesignup.attributedPlaceholder=NSAttributedString(string: "userName", attributes: [NSForegroundColorAttributeName:UIColor.red])
            
        }
        else if(!(usernamesignup.text?.isEmpty)! && (emailSignUp.text?.isEmpty)! && !(passwordsignup.text?.isEmpty)!)
        {
            //make email red
            emailSignUp.attributedPlaceholder=NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.red])

            
        }
        else if(!(usernamesignup.text?.isEmpty)! && !(emailSignUp.text?.isEmpty)! && (passwordsignup.text?.isEmpty)!)
        {
            //make pwd red
            passwordsignup.attributedPlaceholder=NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.red])
            
        }
        else if(!(usernamesignup.text?.isEmpty)! && (emailSignUp.text?.isEmpty)! && (passwordsignup.text?.isEmpty)!)
        {
            //make email,pwd empty
            emailSignUp.attributedPlaceholder=NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.red])
            passwordsignup.attributedPlaceholder=NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.red])

            
        }
        else if((usernamesignup.text?.isEmpty)! && (emailSignUp.text?.isEmpty)! && !(passwordsignup.text?.isEmpty)!)
        {
            //make email,username empty
            emailSignUp.attributedPlaceholder=NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.red])
            usernamesignup.attributedPlaceholder=NSAttributedString(string: "userName", attributes: [NSForegroundColorAttributeName:UIColor.red])

            
        }
        else if((usernamesignup.text?.isEmpty)! && !(emailSignUp.text?.isEmpty)! && (passwordsignup.text?.isEmpty)!)
        {
            //make usernmae,pwd empty
            usernamesignup.attributedPlaceholder=NSAttributedString(string: "userName", attributes: [NSForegroundColorAttributeName:UIColor.red])
            passwordsignup.attributedPlaceholder=NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.red])
            
        }
        else
        {
            
            //nets
            //dont let user have same user name
            let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/register.php")! as URL)
            request.httpMethod="POST"
            let postString = "username=\(usernamesignup.text!)&password=\(passwordsignup.text!)&email=\(emailSignUp.text!)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error == nil
                    
                {
                    print(data)
                    print("entered error is nil")
                    DispatchQueue.main.async (execute: { () -> Void in
                        
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("error")
                                return
                            }
                            print(parseJson)
                            let status:String=parseJson["status"] as! String
                           
                            if status == "200"{
                                let name1:String=parseJson["UserName"] as! String
                                let date:String=parseJson["Date"] as! String
                                let emil:String=parseJson["Email"] as! String
                                self.creatingfile(name1: name1,date: date,emik: emil)
                            }
                            else{
                                print("can not create directory folder")
                            }
                            
                            
                            
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
                    //print("error=\(error)")
                    self.dummy.text=error as! String?
                    return
                }
            }//task closing
            task.resume()
            
            
            
            
            
    //CORE DATA CODE
       // CoreDataManager.storeObj(email: self.emailSignUp.text!,name: self.usernamesignup.text!,password: self.passwordsignup.text!)
        //CoreDataManager.fetchObj()
            
            
          //clear the textboxes
            usernamesignup.text=""
            emailSignUp.text=""
            passwordsignup.text=""
      
        }//else closing
        
    }//action closing
    //loginAction
    
    
    
    func creatingfile(name1:String,date:String,emik:String)
    {
        let nameforfolder:String = (name1)
        //creating a folder with name as user
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //server location
        //let documentsDirectory = NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/usersobservation")
        let dataPath = documentsDirectory.appendingPathComponent("\(nameforfolder)")
        //UserDefaults.standard.set(dataPath, forKey: "fileLocation")
        print(dataPath)
        
        //path in string format
        let pathstring = dataPath.path
        print("stirn path \(pathstring)")
        print("email is \(emik)")
        //pathstring.data
        
        do {
            try FileManager.default.createDirectory(atPath: (dataPath.path), withIntermediateDirectories: true, attributes: nil)
            //connect with databse and inser the file path
            let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/savefilepath.php")! as URL)
            request.httpMethod="POST"
            
            let postString = "email=\(emik)&pathforfile=\(dataPath)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error == nil
                    
                {
                    //print("entered error is nil")
                    DispatchQueue.main.async (execute: { () -> Void in
                        
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("error")
                                return
                            }
                            print(parseJson)
                            let status:String=parseJson["status"] as! String
                            
                            if status == "200"{
                                print("directory saved success")
                                
                            }
                            else{
                                print("directory path not saved failed")
                            }
                            
                            
                            
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
                    
                }
            }//task closing
            task.resume()
            
            

            
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        

    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if(usernameLogin.text != "" && passwordLogin.text != "")
        {
            let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/login.php")! as URL)
            request.httpMethod="POST"
            let postString = "email=\(usernameLogin.text!)&password=\(passwordLogin.text!)"
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
                            let status:String=parseJson["status"] as! String
                            //get name from parseJson dictionary
                                                        //print("ans from php: \(email)")
                            //let loginstatus = String(describing: parseJson["flagging"]!)
                             //print(loginstatus)
                            
                            //if there is some user
                            if status == "200"{
                                let username:String = parseJson["UserName"] as! String
                                let email:String=parseJson["Email"]as! String
                                
                                let firstlogin:String=parseJson["FirstTimeLogin"] as! String
                                print(firstlogin)
                                let fileLocation:String=parseJson["fileLocation"] as! String
print("file location is \(fileLocation)")
                                self.performSegue(withIdentifier: "loginSegue", sender: self)
                                UserDefaults.standard.set(username, forKey: "UserName")
                                UserDefaults.standard.set(email, forKey: "Email")
                                UserDefaults.standard.set(firstlogin, forKey: "FirstTimeLogin")
                                UserDefaults.standard.set(2, forKey: "addedcategory")
                                UserDefaults.standard.set(false, forKey: "doneobserving")
                                UserDefaults.standard.set(fileLocation, forKey: "fileLocation")
                                
                                print("entered user name block")
                                print("username: \(username)")
                            }
                            else{
                                self.dummy.text="please enter valid username and password!!!"
                                print("entered username is nil block")
                            }
                            
                            
                            
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
                    self.dummy.text=error as! String?
                    return
                }
            }//task closing
            task.resume()
            
            
        }
        else if(usernameLogin.text == "" && passwordLogin.text != "")
        {
            //username can not be empty
            usernameLogin.attributedPlaceholder=NSAttributedString(string: "userName can not be empty", attributes: [NSForegroundColorAttributeName:UIColor.red])
        }
        else
        {
            //password can not be empty
            passwordLogin.attributedPlaceholder=NSAttributedString(string: "password can not be empty", attributes: [NSForegroundColorAttributeName:UIColor.red])
        }
        
        
        //core data code
        //      let res = CoreDataManager.loginreq(username: self.usernameLogin.text!, password: self.passwordLogin.text!)
        //        print(res)
        //        if(res == true)
        //        {
        //            dummy.text="successful login"
        //            self.performSegue(withIdentifier: "loginSegue", sender: self)
        //
        //        }
        //        else
        //        {
        //            dummy.text="Login failed"
        //        }
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

