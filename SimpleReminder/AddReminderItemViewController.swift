//
//  AddReminderItemViewController.swift
//  SimpleReminder
//
//  Created by Alper on 18/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import Foundation
import UIKit

class AddReminderItemViewController: UITableViewController {
    
    @IBAction func doneBtnPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelBtnPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }

}