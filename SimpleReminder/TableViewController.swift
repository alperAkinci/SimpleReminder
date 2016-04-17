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
    var row0 = "Fuerteventura"
    var checked0 = false{didSet{print(checked0)}}// test : to observe checked0
    var row1 = "Cape Town", checked1 = true
    var row2 = "Istanbul" , checked2 = false
    var row3 = "Podersdorf" , checked3 = true
    var row4 = "Imroz" , checked4 = true
    var row5 = "Alacati" , checked5 = false

    
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderGroupItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(100) as? UILabel
        
        
        if indexPath.row == 0 {
            label?.text = row0
        }else if indexPath.row == 1 {
            label?.text = row1
        }else if indexPath.row == 2 {
            label?.text = row2
        }else if indexPath.row == 3 {
            label?.text = row3
        }else if indexPath.row == 4{
            label?.text = row4
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
        var selectedRow = false
        /*
         Because it is theoretically possible that there is no cell at the specified index-path,
         for example if that row isn’t visible, you need to use the special if let or guard statement.
         */
        guard let cell = selectedCell else {print("Cell is nil")
            return}
        
        if indexPath.row == 0 {
            checked0 = !checked0
            selectedRow = checked0
        } else if indexPath.row == 1 {
            checked1 = !checked1
            selectedRow = checked1
        } else if indexPath.row == 2 {
            checked2 = !checked2
            selectedRow = checked2
        } else if indexPath.row == 3 {
            checked3 = !checked3
            selectedRow = checked3
        } else if indexPath.row == 4 {
            checked4 = !checked4
            selectedRow = checked4
        }
        
        if selectedRow{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
//MARK: - Convenience Methods
    func configureCheckmarkForCell(cell : UITableViewCell,indexPath: NSIndexPath )  {
        var isChecked = false
        
        if indexPath.row == 0 {
            isChecked = checked0
        }else if indexPath.row == 1 {
            isChecked = checked1
        }else if indexPath.row == 2 {
            isChecked = checked2
        }else if indexPath.row == 3 {
            isChecked = checked3
        }else if indexPath.row == 4{
            isChecked = checked4
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

