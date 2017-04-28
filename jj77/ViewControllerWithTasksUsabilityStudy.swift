//
//  ViewControllerWithTasksUsabilityStudy.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 3/4/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit

class ViewControllerWithTasksUsabilityStudy: UIViewController,UITableViewDelegate,UITableViewDataSource,addtaskonclick {
    var nameofObservation=String()
    
    var dataobservedtoadd=[[String:String]]()
    var dataobservedwhole=[[String:String]]()
    var tasksID=[Int]()
    var date=Date()
    var formatter=DateFormatter()
    var email=String()
    var locationfromdbinurlformat:NSURL?
    var catid=Int()
    var navTitle=String()
    var tasksList=[String]()
    var taskname=String()
    @IBAction func doneObservingAction(_ sender: UIButton) {
        
        print(" data finally observed and need to be stored:\(self.dataobservedwhole)")
        //save it to the csv file
        let ac = UIAlertController(title: "Do You want to save the Observation", message: "Click cancle to continue observing", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            //go back to tasks page
            UserDefaults.standard.set(true, forKey: "firstObser")
            let alerttext=ac.textFields?[0]
            self.nameofObservation=(alerttext?.text)!
            
           //here get the location from database
            self.email=UserDefaults.standard.string(forKey: "Email")!
            self.getLocationFormdb(emil: self.email)
            
            
            
            
            
            

                   }
        
        ac.addAction(okAction)
        ac.addTextField { (textfield:UITextField) in
            //can customize the text field here
            textfield.placeholder="Type name here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) in
            
        }
        ac.addAction(cancelAction)
        present(ac, animated: true, completion: nil)
        

        //send to the observations page to view
        
        //clear the userdefault
        UserDefaults.standard.removeObject(forKey: "observeddatawhole")
        UserDefaults.standard.removeObject(forKey: "observeddatatoAddtowhole")
        
    }
    
    
    func getLocationFormdb(emil:String)
    {
        let currentDate=self.formatter.string(from: self.date)
        
        //write database connections
        let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/getfilepath.php")! as URL)
        request.httpMethod="POST"
        let postString = "email=\(emil)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            data, response, error in
            if error == nil
                
            {
                print("entered error is nil")
                DispatchQueue.main.async (execute: { () -> Void in
                    
                    do {
                        //get json result
                        print("entered do")
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        //print(json)
                        //assign json to new var parsejson in secured way
                        guard let parseJson = json else{
                            print("error")
                            return
                        }
                        print(parseJson)
                        let locationstring:String=parseJson["filelocation"] as! String
                        let lp=locationstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        print("file location retrieved from db is :\(locationstring)")
                        let url = URL(string: lp!)! as! URL
                        //self.locationfromdbinurlformat=NSURL(string: locationstring)
                        //self.locationfromdbinurlformat=URL(locationstring:String)
                        print("file location retrieved from db is in url form \(url)")
                        
                        
                        
                        //saving to file
                        let fileName = "\(self.nameofObservation),Category:\(self.navTitle).csv"
                        let fileexactpath=url.appendingPathComponent(fileName)
                        print(fileexactpath)
                        var csvText = "Observation Name,Observation Category,Date\n"
                                let newLineHeading = "\(self.nameofObservation),\(self.navTitle),\(currentDate)\n"
                                csvText.append(newLineHeading)
                                //assigning each observation of data observed to new line and add it to the
                                for obsdata in self.dataobservedwhole {
                                    for (key,value) in obsdata {
                                        let newdataLine = "\(key),\(value)\n"
                                        csvText.append(newdataLine)
                                    }
                                }
                        print(csvText)
                        do {
                                        try csvText.write(to: fileexactpath, atomically: true, encoding: String.Encoding.utf8)
                                        print("file created successfully")
                                        //            //self.filenamesstored=UserDefaults.standard.array(forKey: "observedfileNamesarray") as! [String]
                            
                                        //            self.filenamesstored.append(fileName)
                                        //            //UserDefaults.standard.set(self.filenamesstored, forKey: "observedfileNamesarray")
                                        //            self.performSegue(withIdentifier: "showObservations", sender: self)
                                        //
                        } catch let error as NSError {
                            print("Failed writing to URL: \(fileexactpath), Error: " + error.localizedDescription)
                        }



                        
                        
                        
                    }catch
                    {
                        print("error: \(error)")
                    }
                    //print("response = \(response)")
                    let responseString = NSString(data: data!,encoding:String.Encoding.utf8.rawValue)
                    //print("response string = \(responseString!)")
                    
                })
                
                
            }
            else
            {
                print("entered error is not nill")
//                print("error=\(error)")
//                self.dummy.text=error as! String?
                return
            }
        }//task closing
        task.resume()

    
    }
    
    
    
    
    
    @IBOutlet weak var tableWithTasks: UITableView!
    
    @IBOutlet weak var instructionsDisplay: UITextView!
    
    @IBAction func startObservingAction(_ sender: Any) {
        
      self.performSegue(withIdentifier: "defaultObservationTaking", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "defaultObservationTaking"
        
        {
           if let destination = segue.destination as? ObservationTakingViewController
           {
            destination.navTitle=self.navTitle
            destination.taskname=self.taskname
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tasksList != nil)
        {
       return self.tasksList.count
        }
        else{
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        if(tasksList != nil)
        {
        cell.textLabel?.text=self.tasksList[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath=tableView.indexPathForSelectedRow
        let currentCell=tableView.cellForRow(at: indexPath!)! as UITableViewCell
        self.taskname=(currentCell.textLabel?.text)!

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height = CGFloat(28)
        return height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header=Bundle.main.loadNibNamed("TasksheadertableTableViewCell", owner: self, options: nil)?.first as! TasksheadertableTableViewCell
        header.delegates=self
        return header
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete
            {
                let datatobedeleted = self.tasksList[indexPath.row]
                let taskIDtobedeleted = self.tasksID[indexPath.row]
                print(taskIDtobedeleted)
                self.tasksList.remove(at: indexPath.row)
                tableView.reloadData()
                
                
                //delete the task from database here
                
                let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/deleteTasks.php")! as URL)
                request.httpMethod="POST"
                let postString = "taskID=\(taskIDtobedeleted)"
                request.httpBody = postString.data(using: String.Encoding.utf8)
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error == nil
                        
                    {
                        //print(data)
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
                                    print("deleted task success")
                                    
                                }
                                else{
                                    print("can not delete task")
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
                        
                        return
                    }
                }//task closing
                task.resume()
                

                
                
                
                
                
                
                
                
                
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat="MM/dd/yy"
        print(navTitle)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationItem.title=self.navTitle
        self.tableWithTasks.delegate=self
        self.tableWithTasks.dataSource=self
        
        //apply the adding tasks functionalitty
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("The cats transfered \(self.catid)")
        
        
        //connect to database and retrive the tasks from database
        
        let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/tasksretriving.php")! as URL)
        request.httpMethod="POST"
        let postString = "categoryID=\(self.catid)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error == nil
                
            {
                //print(data)
                print("entered error is nil")
                DispatchQueue.main.async (execute: { () -> Void in
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:String]]
                        
                        guard let parseJson = json else{
                            print("error")
                            return
                        }
                        print(parseJson)
                        self.tasksList.removeAll()
                        self.tasksID.removeAll()
                        for var i in 0 ..< (json?.count)!
                        {

                        self.tasksList.append((json?[i]["Tname"]!)!)
                            self.tasksID.append(Int((json?[i]["TID"]!)!)!)
                        }
                        print("tasks are:\(self.tasksList)")
                        self.tableWithTasks.reloadData()
                        
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
                
                return
            }
        }//task closing
        task.resume()
        
        

        
        
        
        
        
        
        
        
        
        
        
        //get the to add array
        if((UserDefaults.standard.bool(forKey: "doneobserving") == true))
      {
        if(UserDefaults.standard.bool(forKey: "firstObser") == false)
        {
        self.dataobservedtoadd=UserDefaults.standard.array(forKey: "observeddatatoAddtowhole") as! [[String : String]]
        self.dataobservedwhole=UserDefaults.standard.array(forKey: "observeddatawhole") as! [[String : String]]
        
        //merge it with already saved array
        self.dataobservedwhole.append(contentsOf: self.dataobservedtoadd)
        //save the new array
            UserDefaults.standard.set(self.dataobservedwhole, forKey: "observeddatawhole")
            print("ni bon \(UserDefaults.standard.array(forKey: "observeddatawhole"))")
        }
        else
        {
            self.dataobservedwhole=UserDefaults.standard.array(forKey: "observeddatawhole") as! [[String : String]]
        }
            
        }
     }

    
    func showAlertWithTextforaddingcell()
    {
        let alert=UIAlertController(title:"Add Task",message:"Please enter the name of task",preferredStyle:.alert)
        
        //ok action
        let ok=UIAlertAction(title:"OK",style:UIAlertActionStyle.default){(_) in
            let alertTextField=alert.textFields?[0]
            let nameoftasktosend = ((alertTextField?.text)!)
          //  print(nameoftasktosend)
            self.tasksList.append((alertTextField?.text)!)
            self.tableWithTasks.reloadData()
            
            
            //connect to database and add the task here
            
            
            let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/inserttasksandcolumns.php")! as URL)
            request.httpMethod="POST"
            let postString = "categoryID=\(self.catid)&taskname=\(nameoftasktosend)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error == nil
                    
                {
                    //print(data)
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
                                print("successcfully added task and cols")
                            }
                            else{
                                print("can not add task and col")
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
                    
                    return
                }
            }//task closing
            task.resume()

            
            
            
            
            
            
            
            
            
            
            
        }
        //add text field
        alert.addTextField { (textfield:UITextField) in
            //can customize the text field here
            textfield.placeholder="Enter name  here"
        }
        alert.addAction(ok)
        //cancel action
        let cancel=UIAlertAction(title:"Cancel",style:UIAlertActionStyle.cancel,handler:nil)
        alert.addAction(cancel)
        //present on screen
        self.present(alert,animated:true,completion:nil)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
       
        UserDefaults.standard.set(false, forKey: "doneobserving")
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
