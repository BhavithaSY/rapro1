//
//  TableViewCellHeader.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 2/28/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit
protocol showAlertOnCLick {
    
    func showAlertWithText(tableNum:Int)
    func showAlertWithTextforHeader(tableNum:Int)
    
}

class TableViewCellHeader: UITableViewCell {
    
    var delegate:showAlertOnCLick!
    
    var headerCellSection:Int?
    var headerCellTable:Int?
    
    @IBOutlet weak var changenameonclick: UIButton!
    
    
    @IBOutlet weak var addColumnButton: UIButton!
    
    @IBAction func addRowButtonAction(_ sender: UIButton) {
        
        self.delegate.showAlertWithText(tableNum: self.headerCellTable!)

    }
    
    @IBAction func changename(_ sender: UIButton) {
         self.delegate.showAlertWithTextforHeader(tableNum: self.headerCellTable!)
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
