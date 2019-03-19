//
//  Models.swift
//  Todo
//
//  Created by Michael Rose on 3/18/19.
//  Copyright © 2019 Rosem Inc. All rights reserved.
//

import Foundation

struct Task {

    let id: String
    let name: String
    let note: String
    let isDone: Bool

    init(task: ListTask) {
        id = task.id
        name = task.name
        note = task.note ?? ""
        isDone = task.isDone
    }

}
