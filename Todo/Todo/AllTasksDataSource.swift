//
//  AllTasksDataSource.swift
//  Todo
//
//  Created by Michael Rose on 3/19/19.
//  Copyright © 2019 Rosem Inc. All rights reserved.
//

import UIKit

struct ListSection {
    let title: String
    var tasks: [Task]

    init(title: String, tasks:[Task]) {
        self.title = title
        self.tasks = tasks
    }
}

class AllTasksDataSource: NSObject {

    

    var sections: [ListSection] = []

    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "1")
    }

    func createTask(createdTask: Task, insertAt destinationIndexPath: IndexPath) {
        sections[destinationIndexPath.section].tasks.insert(createdTask, at: destinationIndexPath.row)
    }

    func updatedTask(updatedTask: Task, movedFrom sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sections[sourceIndexPath.section].tasks.remove(at: sourceIndexPath.row)
        sections[destinationIndexPath.section].tasks.insert(updatedTask, at: destinationIndexPath.row)
    }

    func deleteTask(indexPath: IndexPath) {
        sections[indexPath.section].tasks.remove(at: indexPath.row)
    }
    
}

// MARK: - UITableViewDataSource
extension AllTasksDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tasks.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = sections[indexPath.section].tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "1", for: indexPath)
        cell.textLabel!.text = task.name
        cell.accessoryType = task.isDone ? .checkmark : .none

        return cell
    }

}

