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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
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
        
        loadItems()
        
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
        saveItems()
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
                self.saveItems()
                
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
    
    //MARK: - Data manipulations methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArrey)
            try data.write(to:dataFilePath!)
        } catch {
            print("Error encoding item arrey, \(error)")
        }
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArrey = try decoder.decode([Item].self, from: data)
            } catch {
                print("Decoding item arrey error, \(error)")
            }
        }
        
        tableView.reloadData()
    }
    
}

