//
//  Item.swift
//  Todo
//
//  Created by Egor Tkachenko on 18/02/2019.
//  Copyright © 2019 ET. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects.init(fromType: Category.self, property: "items")
    
}
