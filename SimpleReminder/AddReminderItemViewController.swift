//
//  AddReminderItemViewController.swift
//  SimpleReminder
//
//  Created by Alper on 18/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import Foundation
import UIKit

protocol AddReminderItemViewControllerDelegate : class {
    
    func addReminderItemViewController(sender : AddReminderItemViewController , didFinishAddingItem item : ReminderItem)
    
    func addReminderItemViewControllerDidCancel(sender : AddReminderItemViewController)
}


class AddReminderItemViewController: UITableViewController , UITextFieldDelegate {
    
    weak var delegate : AddReminderItemViewControllerDelegate?
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
   
    
    
    //MARK : IBActions
    
    @IBAction func doneBtnPressed(sender: AnyObject) {
        
        let newReminder = ReminderItem()
        newReminder.text = textField.text!
        newReminder.isChecked = false
        
        delegate?.addReminderItemViewController(self, didFinishAddingItem: newReminder)
        
        }
    
    @IBAction func cancelBtnPressed(sender: UIBarButtonItem) {
        
        delegate?.addReminderItemViewControllerDidCancel(self)
        
    }
    
    
    
    //MARK : View Controller Lifecycle
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        
    }
    
    //MARK : UITableViewDelegate
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //MARK: UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //textField is empty or not (shorthand comparison)
        doneBtn.enabled = !(range.location == 0 && string.characters.count == 0)
        return true
    }
    
 

}