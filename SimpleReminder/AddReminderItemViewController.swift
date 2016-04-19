//
//  AddReminderItemViewController.swift
//  SimpleReminder
//
//  Created by Alper on 18/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import Foundation
import UIKit

class AddReminderItemViewController: UITableViewController , UITextFieldDelegate {
    
    var newReminder = ReminderItem()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
   
    @IBAction func doneBtnPressed(sender: AnyObject) {
        
        
        //items.append(newReminder!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK : View Controller Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //textField is empty or not (shorthand comparison)
        doneBtn.enabled = !(range.location == 0 && string.characters.count == 0)
        return true
    }
    
 

}