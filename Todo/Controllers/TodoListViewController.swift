//
//  ViewController.swift
//  Todo
//
//  Created by Egor Tkachenko on 25/12/2018.
//  Copyright © 2018 ET. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var itemArrey = [Item]()
    var itemStringsArrey = ["Study Swift", "Read Scrum", "Watch Spider Man", "Kiss Zayka"]

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //TODO: remove this part
        for title in itemStringsArrey {
            let item = Item()
            item.title = title
    
            itemArrey.append(item)
        }
        
        if let list = defaults.array(forKey: "TodoListArrey") as? [Item] {
            itemArrey = list
        }
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrey.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArrey[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArrey[indexPath.row].done = !itemArrey[indexPath.row].done
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                
                let item = Item()
                item.title = textField.text!
                
                self.itemArrey.append(item)
                
                self.defaults.set(self.itemArrey, forKey: "TodoListArrey")
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

