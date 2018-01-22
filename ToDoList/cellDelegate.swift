//
//  cellDelegate.swift
//  ToDoList
//
//  Created by Jihun Kang on 1/18/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit

protocol cellDelegate: class {
    func addButtonPressed(by controller: NewItemViewController, title: String, date: Date, description: String)
}
