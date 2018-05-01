//
//  Task+Convenience.swift
//  Task
//
//  Created by Michael Duong on 1/24/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String?, due: Date?, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
    self.init(context: context)
    self.name = name
    self.notes = notes
    self.due = due
    self.isComplete = false
    }
}
