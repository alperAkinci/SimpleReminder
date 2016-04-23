//
//  ReminderDetailViewController.swift
//  SimpleReminder
//
//  Created by Alper on 18/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import Foundation
import UIKit

protocol ReminderDetailViewControllerDelegate : class {
    
    func addReminderItemViewController(sender : ReminderDetailViewController , didFinishAddingItem item : ReminderItem)
    
    func addReminderItemViewController(sender : ReminderDetailViewController , didFinishEditingItem item : ReminderItem)
    
    func addReminderItemViewControllerDidCancel(sender : ReminderDetailViewController)
    
    

}


class ReminderDetailViewController: UITableViewController , UITextFieldDelegate {
    
    var reminderToEdit : ReminderItem?
    
    weak var delegate : ReminderDetailViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
        
   
    
    
    //MARK : IBActions
    
    @IBAction func doneBtnPressed(sender: AnyObject) {
        
        
        if let editItem = reminderToEdit{
        
            editItem.text = textField.text!
            delegate?.addReminderItemViewController(self, didFinishEditingItem: editItem)
        
        }else{
        
            let newReminder = ReminderItem()
            
            newReminder.text = textField.text!
            newReminder.isChecked = false
            
            delegate?.addReminderItemViewController(self, didFinishAddingItem: newReminder)
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
        
        
       
    
    @IBAction func cancelBtnPressed(sender: UIBarButtonItem) {
        
        delegate?.addReminderItemViewControllerDidCancel(self)
        
    }
    
    
    
    //MARK : View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let editItem = reminderToEdit {
            
            title = "Edit Reminder"
            textField.text = editItem.text
        
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        
        doneButtonActivationAtTheStart()    
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
    
    
    func doneButtonActivationAtTheStart(){
        
        doneBtn.enabled = !((textField.text?.isEmpty)!)

    
    }
    
 

}