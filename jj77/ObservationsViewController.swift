//
//  ObservationsViewController.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 2/23/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit

class ObservationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var addNewObservation: UIButton!
    
    @IBOutlet weak var observationtable: UITableView!
    
    var filename=String()
    var categoryName=String()
    
    var fileningtoshow=[String]()
    var categorytoshoe=[String]()
    
    @IBAction func addnewobservationaction(_ sender: UIButton) {
        
        tabBarController?.selectedIndex=1
        
        
        
    }
    
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(UserDefaults.standard.object(forKey: "filenametoshow")  != nil && UserDefaults.standard.object(forKey: "catnametoshow") != nil)
        {
        self.filename=UserDefaults.standard.object(forKey: "filenametoshow") as! String
        self.categoryName=UserDefaults.standard.object(forKey: "catnametoshow") as! String
        }
        self.fileningtoshow.append(self.filename)
        self.categorytoshoe.append(self.categoryName)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.title="OBSERVATIONS"
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(UserDefaults.standard.string(forKey: "UserName")!)", style: .plain, target: self, action: #selector(nameTapped))
        
        //getting the location of the file form userdefaults
        let filepath=UserDefaults.standard.object(forKey: "fileLocation") as! String
        print(filepath)
       
       // let theFileName = (filepath as NSString).lastPathComponent
        //print("file names are...\(theFileName)")
      let som=URL(string: filepath)
        print("file path retrieved is \(som)")
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: som as! URL, includingPropertiesForKeys: nil, options: [])
            //print("all the files are \(directoryContents)")
            
//            // if you want to filter the directory contents you can do like this:
            let csv = directoryContents.filter{ $0.pathExtension == "csv" }
           // print("csv urls:",csv)
            fileningtoshow = csv.map{ $0.deletingPathExtension().lastPathComponent }
            observationtable.reloadData()
            print("mp3 list:", fileningtoshow)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
//        //getting all the categories
//        let email=UserDefaults.standard.string(forKey: "Email")!
//        let firstTimeLogin=UserDefaults.standard.integer(forKey: "FirstTimeLogin")
//        let addedcat=UserDefaults.standard.integer(forKey: "addedcategory")
//        // print("addedcat\(self.addedcat)")
//        //print(email)
//        //print(firstTimeLogin)
//        //        if firstTimeLogin == 1
//        //        {
//        // here fetch the categories and subtitle form database categories default table
//        
//        let request = NSMutableURLRequest(url:NSURL(string:"http://localhost:8888/PHP/DataCollection/categoriesData.php")! as URL)
//        request.httpMethod="POST"
//        //print(self.firstTimeLogin)
//        
//        let postString = "email=\(email)&firstLogin=\(firstTimeLogin)&addcat=\(addedcat)"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//        let task = URLSession.shared.dataTask(with: request as URLRequest){
//            data, response, error in
//            if error == nil
//                
//            {
//                print("entered error is nil")
//                DispatchQueue.main.async (execute: { () -> Void in
//                    
//                    do {
//                        //get json result
//                        //print("entered do")
//                        //print(data)
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:String]]
//                        //assign json to new var parsejson in secured way
//                        guard json != nil else
//                        {
//                            print("error")
//                            return
//                        }
//                        
//                        //print(json)
//                        //print(json?.count)
//                        if(firstTimeLogin==1 && addedcat==2)
//                        {
//                            self.catDb.removeAll()
//                            self.catsubsDb.removeAll()
//                        }
//                        else
//                        {
//                            self.catDb=["Usability Study ","Focus Groups","Dynamic systems observations"]
//                            self.catsubsDb=["Testing the usage of each developed product","REquirements gathering observations","Testing the products in mobile environment"]
//                        }
//                        
//                        print(self.catDb)
//                        for var i in 0 ..< (json?.count)!
//                        {
//                            self.catDb.append((json?[i]["CName"]!)!)
//                        }
//                        for var i in 0 ..< (json?.count)!
//                        {
//                            self.catsubsDb.append((json?[i]["Csubtitle"]!)!)
//                        }
//                        print("table data\(self.catDb)")
//                        self.noofsections=self.catDb.count
//                        self.observationtable.reloadData()
//                        // self.CategoriesTable.reloadData()
//                        
//                        
//                    }catch
//                    {
//                        print("error: \(error)")
//                    }
//                    //print("response = \(response)")
//                    let responseString = NSString(data: data!,encoding:String.Encoding.utf8.rawValue)
//                    // print("response string = \(responseString!)")
//                    
//                })
//                
//                
//            }
//            else
//            {
//                
//                return
//            }
//        }//task closing
//        task.resume()
//        
//
        

    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.title="OBSERVATIONS"
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        let right = UIBarButtonItem(title: "\(UserDefaults.standard.string(forKey: "UserName")!)", style: .plain, target: self, action: #selector(nameTapped))
        self.tabBarController?.navigationItem.setRightBarButton(right, animated: true)
        self.navigationController?.title="Observations"
        self.observationtable.delegate=self
        self.observationtable.dataSource=self
        self.observationtable.reloadData()
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    func nameTapped()
    {
        tabBarController?.selectedIndex=2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!self.fileningtoshow.isEmpty)
        {
        return self.fileningtoshow.count
        }
        else
        {
            return 0
        }
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.catDb.count
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print("categoris data id \(catDb)")
//        return catDb[section]
//        
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celliu", for: indexPath)
        if(!(self.fileningtoshow.isEmpty))
        {
        cell.textLabel?.text=self.fileningtoshow[indexPath.row]
       // cell.detailTextLabel?.text=self.categorytoshoe[indexPath.row]
        }
        return cell
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
