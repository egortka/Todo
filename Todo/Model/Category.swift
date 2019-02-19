//
//  Category.swift
//  Todo
//
//  Created by Egor Tkachenko on 18/02/2019.
//  Copyright © 2019 ET. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
