//
//  NotesViewController.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 3/6/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit

protocol NotesProtocal {
//    var nameofNotes : String { get set }
//    
//    var contentOfString : String  { get set }
    func noteDetails(nameOfNote: String,contentOfNote:String)
}


class NotesViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var notesTextArea: UITextView!
    
    var navTitle=String()
    var nameOfNotes=String()
    var delegate:NotesProtocal!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTextArea.delegate=self
        
    
       notesTextArea.text = "Please enter a note here....."
       notesTextArea.textColor = UIColor.darkGray
        self.navigationItem.title=self.navTitle
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        let rightItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: Selector(("Save")))
        navigationItem.rightBarButtonItem = rightItem
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.delegate.noteDetails(nameOfNote: self.nameOfNotes,contentOfNote: self.notesTextArea.text)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title=self.navTitle
        notesTextArea.text = "Please enter a note here....."
        notesTextArea.textColor = UIColor.darkGray
       self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func Save()
    {
        
        let alert=UIAlertController(title:"Name",message:"Please enter the Name of Notes here",preferredStyle:.alert)
      let ok=UIAlertAction(title:"Done",style:UIAlertActionStyle.default){(_) in
            //self.performSegue(withIdentifier: "SaveNotesGoBack", sender: self)
        let alerttext=alert.textFields?[0]
        self.nameOfNotes=(alerttext?.text)!
        print(self.nameOfNotes)
      self.delegate.noteDetails(nameOfNote: self.nameOfNotes,contentOfNote: self.notesTextArea.text)
_ = self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
      //  self.performSegue(withIdentifier: "showBack", sender: self)
        
        }
        alert.addAction(ok)
        alert.addTextField { (textfield:UITextField) in
            //can customize the text field here
            textfield.placeholder="Type name here"
        }
        self.present(alert,animated:true,completion:nil)
        
    }

    
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView==self.notesTextArea)
        {
            if textView.text=="Please enter a note here....."
            {
                textView.text=nil
                textView.textColor=UIColor.black
            }
        }
    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView==self.notesTextArea
//        {
//            if textView.text.isEmpty
//            {
//                textView.text="Please enter a note here....."
//                textView.textColor=UIColor.lightGray
//            }
////            textView.becomeFirstResponder()
//        }
//    }
    
    
    
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
