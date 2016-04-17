//
//  ReminderItem.swift
//  SimpleReminder
//
//  Created by Alper on 17/04/16.
//  Copyright © 2016 alper. All rights reserved.
//

import Foundation
import UIKit

class ReminderItem {
    
    var text = " "
    var isChecked = false
    
    
    func checkmarkToggled(){
        isChecked = !isChecked
    }
    
}