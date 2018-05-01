//
//  TaskController.swift
//  Task
//
//  Created by Michael Duong on 1/24/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        let completedSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: false)
        let dueSortDescriptor = NSSortDescriptor(key: "due", ascending: false)
        
        fetchRequest.sortDescriptors = [completedSortDescriptor, dueSortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
    }()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error while fetching: \(error.localizedDescription)")
        }
    }
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        let task = Task(name: name, notes: notes, due: due, isComplete: false)
//        tasks.append(newTask)
        saveToPersistentStore()
//        tasks = fetchTask()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
//        tasks = fetchTask()
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
            saveToPersistentStore()
//            tasks = fetchTask()
        }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
            print("\n\n save \n\n")
        } catch let error {
            print("There was an problem saving: \(error.localizedDescription)")
        }
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
}
