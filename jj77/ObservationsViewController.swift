//
//  ObservationsViewController.swift
//  jj77
//
//  This tool was created by Bhavithasai Yendrathi on 2/23/17, in collboration with Dr. Steven C. Sutherland at the University of Houston-Clear Lake and Dr. Farzan Sasangohar at Texas A&M University. This project was funded by an internal grant from the University of Houston-Clear Lake.
//  Copyright © 2017 Univerity of Houston-Clear Lake. All rights reserved.
//

import UIKit
//for emailing
import MessageUI

class ObservationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
       
    
    @IBAction func emailAction(_ sender: Any) {
        
        //tabBarController?.selectedIndex=1

    }
    
    
    @IBOutlet weak var addNewObservation: UIButton!
    
    @IBOutlet weak var observationtable: UITableView!
    
    var filename=String()
    var categoryName=String()
    var filesurls=[URL]()
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
            filesurls = directoryContents.filter{ $0.pathExtension == "csv" }
           print("csv urls:",filesurls)
            fileningtoshow = filesurls.map{ $0.deletingPathExtension().lastPathComponent }
            observationtable.reloadData()
            print("mp3 list:", fileningtoshow)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
      

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
        //let cell = tableView.dequeueReusableCell(withIdentifier: "celliu", for: indexPath)
       let cell=Bundle.main.loadNibNamed("AllObservationsTableViewCell", owner: self, options: nil)?.first as! AllObservationsTableViewCell
        cell.email.tag=indexPath.row
        cell.email.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        if(!(self.fileningtoshow.isEmpty))
        {
        cell.textLabel?.text=self.fileningtoshow[indexPath.row]
       // cell.detailTextLabel?.text=self.categorytoshoe[indexPath.row]
        }
        return cell
    }
    
   
    //emailing functionality goes here
    
    func buttonTapped(_ sender : UIButton){
        let buttonTag = sender.tag
        print(buttonTag)
        print("e")
        let urlpaths=filesurls[buttonTag]
        print("file url is \(filesurls[buttonTag])")
        
        // Generating the email controller.
        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            
            //Set the subject and message of the email
            mailComposer.setSubject("Have you heard a swift?")
            mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
            
            let filePath = filesurls[buttonTag].path
            
            print("File path loaded.")
            
            if let fileData = NSData(contentsOfFile: filePath) {
                print("File data loaded.")
                mailComposer.addAttachmentData(fileData as Data, mimeType: "text/csv", fileName: fileningtoshow[buttonTag])
            }
            
        self.present(mailComposer, animated: true, completion: nil)
    }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismiss(animated: true, completion: nil)
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
