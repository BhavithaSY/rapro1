//
//  CategoriesViewController.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 2/23/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//
import UIKit

class CategoriesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
//    var catDb:[String]=["Usability Study ","Focus Groups","Dynamic systems observations"]
//    var catsubsDb:[String]=["Testing the usage of each developed product","Requirements gathering observations","Testing the products in mobile environment"]
//    var catsId:[Int]=[1,2,3]

    var catDB=[String]()
    var catsubsDb=[String]()
    var catsId=[Int]()
    
    
    var email=String()
    var firstTimeLoaded=Bool()
    var firstTimeLogin=Int()
    var addedcat=Int()
    var selectedcatid=Int()
    //var categories:[String]=["Usability Study ","Focus Groups","Dynamic systems observations"]
    // var categoriesSubtitle:[String]=["Testing the usage of each developed product","REquirements gathering observations","Testing the products in mobile environment"]
    var selectedCategory:String = ""
    
    
    @IBOutlet weak var CategoriesTable: UITableView!
    
    @IBOutlet weak var customizingView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.title="CATEGORIES"
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        CategoriesTable.delegate = self
        CategoriesTable.dataSource = self
        CategoriesTable.reloadData()
        customizingView.isHidden=true
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.title="CATEGORIES"
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        email=UserDefaults.standard.string(forKey: "Email")!
        firstTimeLogin=UserDefaults.standard.integer(forKey: "FirstTimeLogin")
        addedcat=UserDefaults.standard.integer(forKey: "addedcategory")
        print("addedcat\(self.addedcat)")
        //print(email)
        //print(firstTimeLogin)
        //        if firstTimeLogin == 1
        //        {
        // here fetch the categories and subtitle form database categories default table
        let request = NSMutableURLRequest(url:NSURL(string:"http://sceweb.sce.uhcl.edu/yendrathib/categoriesData.php")! as URL)
        request.httpMethod="POST"
        print(self.firstTimeLogin)
        
        let postString = "email=\(self.email)&firstLogin=\(self.firstTimeLogin)&addcat=\(self.addedcat)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error == nil
                
            {
                print("entered error is nil")
                DispatchQueue.main.async (execute: { () -> Void in
                    
                    do {
                        //get json result
                        //print("entered do")
                        //print(data)
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:String]]
                        //assign json to new var parsejson in secured way
                        guard json != nil else
                        {
                            print("error")
                            return
                        }
                        
                        print(json)
                        //print(json?.count)
//                        if(self.firstTimeLogin==1 && self.addedcat==2)
//                        {
//                            self.catDb.removeAll()
//                            self.catsubsDb.removeAll()
//                            self.catsId.removeAll()
//                        }
//                        else
//                        {
//                            self.catDb=["Usability Study ","Focus Groups","Dynamic systems observations"]
//                            self.catsubsDb=["Testing the usage of each developed product","REquirements gathering observations","Testing the products in mobile environment"]
//                            self.catsId=[1,2,3]
//                        }
//                        
//                        print(self.catDb)
                        for var i in 0 ..< (json?.count)!
                        {
                            self.catDB.append((json?[i]["CName"]!)!)
                            self.catsubsDb.append((json?[i]["Csubtitle"]!)!)
                            self.catsId.append(Int((json?[i]["CID"]!)!)!)
                            
                        }
//                        for var i in 0 ..< (json?.count)!
//                        {
//                            self.catsubsDb.append((json?[i]["Csubtitle"]!)!)
//                        }
                        //print("table data\(self.catDB)")
                        //print("ids retrieved \(self.catsId)")
                        self.CategoriesTable.reloadData()
                        
                        
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
                
                return
            }
        }//task closing
        task.resume()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.catDB.removeAll()
        self.catsubsDb.removeAll()
    }
    func numberOfSections(CategoriesTable: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ CategoriesTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return categories.count
        return self.catDB.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Observation Type"
    }
    
    func tableView(_ CategoriesTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoriesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text=categories[indexPath.row]
        cell.textLabel?.text=self.catDB[indexPath.row]
        //cell.detailTextLabel?.text=categoriesSubtitle[indexPath.row]
        cell.detailTextLabel?.text=self.catsubsDb[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ CategoriesTable: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // print("User selected table row \(indexPath.row) and item \(categories[indexPath.row])")
        //selectedCategory=categories[indexPath.row]
        self.selectedCategory=self.catDB[indexPath.row]
        self.selectedcatid=self.catsId[indexPath.row]
        let ac = UIAlertController(title: "Title", message: "please choose the observation type", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Customize", style: .default) { (_) in
            //presentViewController(yourSetupController, animated: true, completion: nil)
            self.customizingView.isHidden=false
            
        }
        ac.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Default", style: .default) { (_) in
            self.performSegue(withIdentifier: "pageWithTasks", sender: self)
            //print("Hello")
            //            let storyboardid = UIStoryboard(name: "categoriesBoard1", bundle: nil)
            //            let controller = storyboardid.instantiateViewController(withIdentifier: "observationtakingboard")
            //            self.present(controller, animated: true, completion: nil)
        }
        
        
        ac.addAction(cancelAction)
        present(ac, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageWithTasks"
        {
            if let destinName=segue.destination as? ViewControllerWithTasksUsabilityStudy
            {
                destinName.navTitle=self.selectedCategory
                destinName.catid=self.selectedcatid
            }
        }
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
