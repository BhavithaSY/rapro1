//
//  TasksheadertableTableViewCell.swift
//  jj77
//
//  Created by Bhavithasai yendrathi on 4/24/17.
//  Copyright © 2017 Bhavithasai yendrathi. All rights reserved.
//

import UIKit
protocol addtaskonclick {
    
    func showAlertWithTextforaddingcell()
    
    
}


class TasksheadertableTableViewCell: UITableViewCell {
    var delegates:addtaskonclick!

    override func awakeFromNib() {
        super.awakeFromNib()
                // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addtasksaction(_ sender: UIButton) {
        
        self.delegates.showAlertWithTextforaddingcell()
        
    }
    
    
}
