//
//  File.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList

final class MockTaskListPresenter: TaskListInteractorOutputProtocol {
    var receivedTasks: TaskListDataStore?
    var didReceiveTaskList: (() -> Void)?

    func taskListDidReceive(with dataStore: TaskListDataStore) {
        self.receivedTasks = dataStore
        didReceiveTaskList?()
    }

    func newSavedTaskDidReceived(with newTask: Task) {
      
    }
}
