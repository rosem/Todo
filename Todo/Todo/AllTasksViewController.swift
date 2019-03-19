//
//  TableViewController.swift
//  Todo
//
//  Created by Michael Rose on 3/19/19.
//  Copyright © 2019 Rosem Inc. All rights reserved.
//

import UIKit
import Apollo

class AllTasksViewController: UITableViewController {

    let TodoIndex = 0
    let DoneIndex = 1

    let dataSource = AllTasksDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        loadTasks()
    }

    func configure() {
        // TODO: Implement empty and/or loading state for table view

        self.title = "My Tasks"
        dataSource.configure(with: tableView)
    }

    func sectionForTask(task: Task) -> Int {
        return task.isDone ? 1 : 0
    }

    @IBAction func didCreate() {
        // TODO: Show create task view controller to allow user input
        createTask(name: "A new task", note: "This is my new task")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleTaskAtIndexPath(sourceIndexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [unowned self] (action, indexPath) in
            self.deleteTask(indexPath: indexPath)
        }

        return [delete]
    }

}

// MARK: Data
extension AllTasksViewController {

    func loadTasks() {
        let query = AllTasksQuery()
        Apollo.shared.client.fetch(query: query) { [unowned self] results, error in
            if let listTasks = results?.data?.allTasks?.compactMap({$0}) {
                let tasks = listTasks.map({Task(task: $0.fragments.listTask)})
                let sections: [ListSection] = [
                    ListSection(title: "Today", tasks: tasks.filter { $0.isDone == false }),
                    ListSection(title: "Done", tasks: tasks.filter { $0.isDone == true })
                ]
                self.dataSource.sections = sections
                self.tableView.reloadData()

            } else if let error = error {
                print("Error loading all tasks \(error)")
            }
        }

    }

    func toggleTaskAtIndexPath(sourceIndexPath: IndexPath) {
        let selectedTask = self.dataSource.sections[sourceIndexPath.section].tasks[sourceIndexPath.row]
        let mutation = UpdateTaskStateMutation(id: selectedTask.id, isDone: !selectedTask.isDone)
        Apollo.shared.client.perform(mutation: mutation) { [unowned self] results, error in
            if let listTask = results?.data?.updateTaskStatus?.fragments.listTask {
                let updatedTask = Task(task: listTask)
                let section = self.sectionForTask(task: updatedTask)
                let row = section == self.TodoIndex ? 0 : self.dataSource.sections[section].tasks.count
                let destinationIndexPath = IndexPath(row: row, section: section)

                self.dataSource.updatedTask(updatedTask: updatedTask, movedFrom: sourceIndexPath, to: destinationIndexPath)
                self.tableView.performBatchUpdates({
                    self.tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
                    self.tableView.deselectRow(at: destinationIndexPath, animated: true)
                }, completion: { (finished) in
                    self.tableView.reloadRows(at: [destinationIndexPath], with: .automatic)
                })

            } else if let error = error {
                print("Error updating task \(error)")
            }
        }
    }

    func createTask(name: String, note: String?, isDone: Bool = false) {
        let mutation = CreateTaskMutation(name: name, note: note, isDone: isDone)
        Apollo.shared.client.perform(mutation: mutation) { [unowned self] results, error in
            if let listTask = results?.data?.createTask?.fragments.listTask {
                let createdTask = Task(task: listTask)
                let section = self.sectionForTask(task: createdTask)
                let row = self.dataSource.sections[section].tasks.count
                let destinationIndexPath = IndexPath(row: row, section: section)

                self.dataSource.createTask(createdTask: createdTask, insertAt: destinationIndexPath)
                self.tableView.performBatchUpdates({
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                }, completion: nil)

            } else if let error = error {
                print("Error creating task \(error)")
            }
        }
    }

    func deleteTask(indexPath: IndexPath) {
        let selectedTask = self.dataSource.sections[indexPath.section].tasks[indexPath.row]
        let mutation = DeleteTaskMutation(id: selectedTask.id)
        Apollo.shared.client.perform(mutation: mutation) { [unowned self] results, error in
            if let error = error {
                print("Error deleting task \(error)")
            } else {
                self.dataSource.deleteTask(indexPath: indexPath)
                self.tableView.performBatchUpdates({
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }, completion: nil)
            }
        }
    }

}
