//
//  ViewController.swift
//  SimpleReminder
//
//  Created by Alper on 16/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import UIKit

class ReminderListViewController: UITableViewController ,AddReminderItemViewControllerDelegate {
    
    // MARK: - Data Model
    
    var items :[ReminderItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ReminderItem]()
        
        let row0Item : ReminderItem? = ReminderItem()
        row0Item?.text = "Fuerteventura"
        row0Item?.isChecked = false
        items.append(row0Item!)
        
        let row1Item : ReminderItem? = ReminderItem()
        row1Item?.text = "Cape Town"
        row1Item?.isChecked = true
        items.append(row1Item!)

        
        let row2Item : ReminderItem? = ReminderItem()
        row2Item?.text = "Istanbul"
        row2Item?.isChecked = true
        items.append(row2Item!)

        
        let row3Item : ReminderItem? = ReminderItem()
        row3Item?.text = "Podersdorf"
        row3Item?.isChecked = true
        items.append(row3Item!)

        
        let row4Item : ReminderItem? = ReminderItem()
        row4Item?.text = "Maui"
        row4Item?.isChecked = true
        items.append(row4Item!)

        
        super.init(coder: aDecoder)
    }
    
    @IBAction func addItem(sender: UIBarButtonItem) {
        
        let indexPath = NSIndexPath(forRow: items.count, inSection: 0)
        
        let row5Item : ReminderItem? = ReminderItem()
        row5Item?.text = "Holaaaa"
        row5Item?.isChecked = false
        items.append(row5Item!)
        
        //tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        //tableView.endUpdates()
    }
    
    
    
// MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    
//MARK: - PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddReminder"){
            
            let nc = segue.destinationViewController as? UINavigationController
        
            let vc = nc?.topViewController as! AddReminderItemViewController
            
            vc.delegate = self
        }
    }
    
//MARK: - TableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderItem", forIndexPath: indexPath)
        
        let item = items[indexPath.row]
        configureTextForCell(cell, withRemiderItem: item)
        configureCheckmarkForCell(cell, withRemiderItem: item)
       
        //print("New Row : \(indexPath.row)")
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //returns a cell object
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        //selected cell could be nil (ex: if its invisible)
        guard let cell = selectedCell else {print("Cell is nil")
            return}
        
        let item = items[indexPath.row]
        
        item.checkmarkToggled()
        configureCheckmarkForCell(cell, withRemiderItem: item)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == UITableViewCellEditingStyle.Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
//MARK: - Convenience Methods
    func configureCheckmarkForCell(cell : UITableViewCell,withRemiderItem item : ReminderItem )  {
        
        let label = cell.viewWithTag(101) as? UILabel
        
        label?.text = ""
        
        if item.isChecked{
            label?.text = "✓"
            
        }else{
            label?.text = ""
        }
        
    }
    
   
    func configureTextForCell(cell : UITableViewCell ,withRemiderItem item : ReminderItem ){
    
        let label = cell.viewWithTag(100) as? UILabel
        
        label?.text = item.text
        
    }
    
//MARK: - AddReminderItemViewController Delegate
    
    func addReminderItemViewControllerDidCancel(sender: AddReminderItemViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addReminderItemViewController(sender: AddReminderItemViewController, didFinishAddingItem item: ReminderItem) {
        
        let indexPath = NSIndexPath(forRow: items.count, inSection: 0)
        
        items.append(item)
        
        tableView.beginUpdates()
        
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        tableView.endUpdates()
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }



}

