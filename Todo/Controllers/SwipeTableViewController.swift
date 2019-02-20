//
//  SwipeTableViewController.swift
//  Todo
//
//  Created by Egor Tkachenko on 19/02/2019.
//  Copyright © 2019 ET. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
    }
    
    //MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        switch orientation {
        case .right:
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.update(at: indexPath)
            }
            
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete")
            
            return [deleteAction]
            
        case .left:
            
            let changeColorAction = SwipeAction(style: .default, title: "ChangeColor") { action, indexPath in
                self.changeColor(at: indexPath)
            }
            return [changeColorAction]
        }
        
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        if orientation == .right {
            options.expansionStyle = .destructive
        } else {
            options.expansionStyle = .fill
        }
        return options
    }
    
    //MARK:
    func update(at indexPath: IndexPath) {
        
    }
    
    func changeColor(at indexPath: IndexPath) {
        
    }
}

