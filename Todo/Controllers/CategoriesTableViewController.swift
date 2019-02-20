//
//  CategoriesTableViewController.swift
//  Todo
//
//  Created by Egor Tkachenko on 07/02/2019.
//  Copyright © 2019 ET. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoriesTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if (textField.text?.count)! > 0 {
                
                let newCategory = Category()
                newCategory.name = textField.text!
                let color = self.generateNewColor()
                newCategory.hexColor = color
                self.save(category: newCategory)
                
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Data manipulations methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func update(at indexPath: IndexPath) {
        if let selectedCategory = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(selectedCategory)
                }
            } catch {
                print("Error deleting category: \(error)")
            }
        }
    }
    
    override func changeColor(at indexPath: IndexPath) {
        if let selectedCategory = categories?[indexPath.row] {
            do {
                try realm.write {
                    selectedCategory.hexColor = generateNewColor()
                }
            } catch {
                print("Error changing color: \(error)")
            }
            tableView.reloadData()
        }
    }


    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            if let color = UIColor.init(hexString: category.hexColor) {
                cell.tintColor = ContrastColorOf(color, returnFlat: true)
                cell.backgroundColor = UIColor.init(hexString: category.hexColor)
            }
        } else {
            cell.textLabel?.text = "There is no Catigories yet"
        }
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItems", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        } else {
            print("Failed to set selectedCategory property!")
        }
    }
    
    //MARK: - Generates new Chameleon hexColor
    func generateNewColor() -> String {
        
        let newColor = UIColor.init(randomColorIn: [FlatRed(), FlatWhite(), FlatOrange(), FlatYellow(), FlatSand(), FlatMagenta(), FlatSkyBlue(), FlatGreen(), FlatMint(), FlatGray(), FlatPurple(), FlatWatermelon(), FlatLime(), FlatPink(), FlatCoffee(), FlatPowderBlue()])
          //  UIColor.init(randomFlatColorExcludingColorsIn: [FlatBlack(), FlatNavyBlue(), FlatBrown(), FlatPlum(), FlatTeal(), FlatBlue()])
        return newColor?.hexValue() ?? ""
        
    }


}


