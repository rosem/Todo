//
//  ViewController.swift
//  Todo
//
//  Created by Michael Rose on 3/18/19.
//  Copyright © 2019 Rosem Inc. All rights reserved.
//

import UIKit
import Apollo

class ViewController: UIViewController {

    var todo: [Task] = []
    var done: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTasks()
        // self.createTask()
    }

    func createTask() {
        let mutation = CreateTaskMutation(name: "Done task", note: "This task is done", isDone: true)
        Apollo.shared.client.perform(mutation: mutation) { results, error in
            if let createdTask = results?.data?.createTask?.fragments.listTask {
                let task = Task(task: createdTask)
                if task.isDone {
                    self.done.append(task)
                } else {
                    self.todo.append(task)
                }

                // TODO: Insert new task into table view
            } else if let error = error {
                print("Error loading data \(error)")
            }
        }
    }

    func loadTasks() {
        let query = AllTasksQuery()
        Apollo.shared.client.fetch(query: query) { [unowned self] results, error in
            if let tasks = results?.data?.allTasks?.compactMap({$0}) {
                let models = tasks.map({Task(task: $0.fragments.listTask)})
                self.todo = models.filter { $0.isDone == false }
                self.done = models.filter { $0.isDone == true }

                // TODO: Reload table view

            } else if let error = error {
                print("Error loading data \(error)")
            }
        }

    }


}

