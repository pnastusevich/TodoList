//
//  Task.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

struct TasksInApi: Decodable {
    let todos: [Tasks]
    let total: Int
}

struct Tasks: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
