//
//  ViewController.swift
//  SimpleReminder
//
//  Created by Alper on 16/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import UIKit
import CoreData

class ReminderListViewController: UITableViewController ,ReminderDetailViewControllerDelegate {
    
    // MARK: - Data Model
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var reminders = [NSManagedObject]()
    
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
    


    
// MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Documents Directory : \(documentsDirectory())")
        //print("Data Path Directory : \(dataFilePath())")
        
        fetchReminders()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
//MARK: - PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddReminder"){
            
            let nc = segue.destinationViewController as? UINavigationController
        
            let vc = nc?.topViewController as! ReminderDetailViewController
            
            vc.delegate = self
        }
        
        else if (segue.identifier == "EditReminder"){
            
            let nc = segue.destinationViewController as? UINavigationController
            
            let vc = nc?.topViewController as! ReminderDetailViewController
            
            vc.delegate = self
            
            guard let cell = tableView.indexPathForCell(sender as! UITableViewCell)else {return}
            
            vc.reminderToEdit = reminders[(cell.row)]
            
            
        }
    }
    
//MARK: - TableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderItem", forIndexPath: indexPath)
        
        let item = reminders[indexPath.row]
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
        
        let item = reminders[indexPath.row]
        
        let itemIsChecked = item.valueForKey("isChecked") as! Bool
        
        item.setValue(!itemIsChecked, forKey: "isChecked")
        
        configureCheckmarkForCell(cell, withRemiderItem: item)
        
        appDelegate.saveContext()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    //Why we use that method?
    //Selected row should get in selected status after accessory button pressed ,to use tableView.indexPathForSelectedRow
    //Reminder : the row selected by user gets in "deselected status" after pressed via tableView(:diddidSelectRowAtIndexPath) method
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == UITableViewCellEditingStyle.Delete {
            reminders.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
        appDelegate.saveContext()
    }
    
    
//MARK: - Convenience Methods
    func configureCheckmarkForCell(cell : UITableViewCell,withRemiderItem item : NSManagedObject )  {
        
        let label = cell.viewWithTag(101) as? UILabel
        
        label?.text = ""
        
        guard let isChecked = item.valueForKey("isChecked") as? Bool else {print ("isChecked value is nil")
                  return
            }
    
        if isChecked{
            label?.text = "✓"
            
        }else{
            label?.text = ""
        }
        
    }
    
   
    func configureTextForCell(cell : UITableViewCell ,withRemiderItem item : NSManagedObject ){
    
        let label = cell.viewWithTag(100) as? UILabel
        
        label?.text = item.valueForKey("text") as? String
        
    }
    
    
    
    func documentsDirectory() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return paths[0]
    }
    
    func dataFilePath() -> String {
        
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Reminders.plist")
        
    }
    
    
    
    func fetchReminders () {
        //1 - before we do anything in CoreData , we need a managed object context . Pull up AppDelegate and grab a referance to its managed object context.
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate?.managedObjectContext
        
        //2 - Make Fetching request via NSFetchRequest
        let fetchRequest = NSFetchRequest(entityName: "ReminderItem")
        
        //3 - Return an array of managed context that specified by fetch request
        do {
            let results = try managedContext?.executeFetchRequest(fetchRequest)
            reminders = results as! [NSManagedObject]
        }catch let error as NSError{
            print("Could not fetch \(error),\(error.userInfo)")
        }
        
    }
    

    
//MARK: - ReminderDetailViewController Delegate
    
    func addReminderItemViewControllerDidCancel(sender: ReminderDetailViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addReminderItemViewController(sender: ReminderDetailViewController, didFinishAddingItem item: NSManagedObject) {
        
        let indexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
        
        reminders.append(item)//to show person when tableView reloads
        
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
        
        
        
        
    }
    
    func addReminderItemViewController(sender : ReminderDetailViewController , didFinishEditingItem item : NSManagedObject){
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else{print("Could not find index path!")
             return}
        
        // Update an existing reminder items.
        reminders[selectedIndexPath.row] = item
        
        appDelegate.saveContext()
        tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Automatic)
           
        
    }
    
    
    
    
   
    




}

