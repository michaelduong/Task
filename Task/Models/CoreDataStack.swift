//
//  CoreDataStack.swift
//  Task
//
//  Created by Michael Duong on 1/24/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation
import CoreData

import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Task")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
}
