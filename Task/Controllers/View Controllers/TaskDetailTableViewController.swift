//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Michael Duong on 1/24/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var taskNotes: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var dueDateValue: Date?
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        dueDate.text = dueDatePicker.date.stringValue()
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.taskName.resignFirstResponder()
        self.dueDate.resignFirstResponder()
        self.taskNotes.resignFirstResponder()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let name = taskName.text  else { return }
        let due = dueDateValue
        let notes = taskNotes.text
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDate.inputView = dueDatePicker
        
        updateViews()
    }

    func updateViews() {
        guard let task = task, isViewLoaded else { return }
        
        taskName.text = task.name
        dueDate.text = task.due?.stringValue()
        taskNotes.text = task.notes
        
    }
    

}
