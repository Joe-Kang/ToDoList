//
//  NewItemViewController.swift
//  ToDoList
//
//  Created by Jihun Kang on 1/18/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {
    
    weak var delegate: cellDelegate?
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBAction func AddItemButton(_ sender: UIButton) {
        let title = TitleTextField.text
        let date = DatePicker.date
        let description = DescriptionTextField.text
        delegate?.addButtonPressed(by: self, title: title!, date: date, description: description!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}

}
