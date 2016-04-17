//
//  ViewController.swift
//  SimpleReminder
//
//  Created by Alper on 16/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
// MARK: - Data Model
    
    var row0Item : ReminderItem?
    var row1Item : ReminderItem?
    var row2Item : ReminderItem?
    var row3Item : ReminderItem?
    var row4Item : ReminderItem?

    required init?(coder aDecoder: NSCoder) {
        row0Item = ReminderItem()
        row0Item?.text = "Fuerteventura"
        row0Item?.isChecked = false
        
        row1Item = ReminderItem()
        row1Item?.text = "Cape Town"
        row1Item?.isChecked = true
        
        row2Item = ReminderItem()
        row2Item?.text = "Istanbul"
        row2Item?.isChecked = true
        
        row3Item = ReminderItem()
        row3Item?.text = "Cape Town"
        row3Item?.isChecked = true
        
        row4Item = ReminderItem()
        row4Item?.text = "Alacati"
        row4Item?.isChecked = true
        
        super.init(coder: aDecoder)
    }
    
// MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//MARK: - TableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(100) as? UILabel
        
        
        if indexPath.row == 0 {
            label?.text = row0Item?.text
        }else if indexPath.row == 1 {
            label?.text = row1Item?.text
        }else if indexPath.row == 2 {
            label?.text = row2Item?.text
        }else if indexPath.row == 3 {
            label?.text = row3Item?.text
        }else if indexPath.row == 4{
            label?.text = row4Item?.text
        }else {
            label?.text = "Empty"
        }
        
        configureCheckmarkForCell(cell, indexPath: indexPath)
        print("New Row : \(indexPath.row)")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //returns a cell object
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        /*
         Because it is theoretically possible that there is no cell at the specified index-path,
         for example if that row isn’t visible, you need to use the special if let or guard statement.
         */
        guard let cell = selectedCell else {print("Cell is nil")
            return}
        
        if indexPath.row == 0 {
            (row0Item!.isChecked) = !(row0Item!.isChecked)
        } else if indexPath.row == 1 {
            (row1Item!.isChecked) = !(row1Item!.isChecked)
        } else if indexPath.row == 2 {
            (row2Item!.isChecked) = !(row2Item!.isChecked)
        } else if indexPath.row == 3 {
            (row3Item!.isChecked) = !(row3Item!.isChecked)
        } else if indexPath.row == 4 {
            (row4Item!.isChecked) = !(row4Item!.isChecked)
            
        }
        
        configureCheckmarkForCell(cell, indexPath: indexPath)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
//MARK: - Convenience Methods
    func configureCheckmarkForCell(cell : UITableViewCell,indexPath: NSIndexPath )  {
        var isChecked = false
        
        if indexPath.row == 0 {
            isChecked = (row0Item!.isChecked)
        }else if indexPath.row == 1 {
            isChecked = (row1Item!.isChecked)
        }else if indexPath.row == 2 {
            isChecked = (row2Item!.isChecked)
        }else if indexPath.row == 3 {
            isChecked = (row3Item!.isChecked)
        }else if indexPath.row == 4{
            isChecked = (row4Item!.isChecked)
        }else {
            isChecked = false
        }

        if isChecked{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
        
    }



}

