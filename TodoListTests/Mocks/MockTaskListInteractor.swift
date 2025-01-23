//
//  MockTaskListInteractor.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList

final class MockTaskListInteractor: TaskListInteractorInputProtocol {
    var fetchTaskListCalled = false
    var doneTaskCalled = false
    var deleteTaskCalled = false
    var taskList: [Task] = []

    required init(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol, presenter: TaskListInteractorOutputProtocol) {}
    
    func fetchTaskList() {
        fetchTaskListCalled = true
    }

    func doneTask(task: Task?) {
        doneTaskCalled = true
    }

    func deleteTask(task: Task) {
        deleteTaskCalled = true
    }

    func giveStorageServices() -> StorageServicesProtocol {
        return MockStorageServices(mockContext: MockStorageServices.createMockContext())
    }
}
