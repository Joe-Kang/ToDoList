//
//  ViewController.swift
//  ToDoList
//
//  Created by Jihun Kang on 1/18/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController, cellDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                print(cell.accessoryType.rawValue)
                items[indexPath.row].checked = true
            } else {
                cell.accessoryType = .none
                print(cell.accessoryType.rawValue)
                items[indexPath.row].checked = false
            }
            do {
                try context.save()
            } catch {
                print(error)
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return items.count}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.titleLabel?.text = items[indexPath.row].title
        cell.descriptionLabel?.text = items[indexPath.row].desc
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let result = format.string(from : items[indexPath.row].date!)
        cell.dateLabel?.text = result
        if items[indexPath.row].checked == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListItem")
        do {
            let result = try context.fetch(request)
            items = result as! [ToDoListItem]
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination
        let newItemViewController = viewController as! NewItemViewController
        newItemViewController.delegate = self
    }
    
    func addButtonPressed(by controller: NewItemViewController, title: String, date: Date, description: String) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoListItem", into: context) as! ToDoListItem
        item.title = title
        item.desc = description
        item.date = date
        item.checked = false
        print("\(date)")
        items.append(item)
        do {
            try context.save()
        } catch {
            print(error)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
}

