//
//  MockTaskListRouter.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList

final class MockTaskListRouter: TaskListRouterInputProtocol {
    var viewController: TaskListViewController?

    required init(view: TaskListViewController) {
        self.viewController = view
    }

    func openTaskDetailsViewController(with task: Task, storageService storageServices: StorageServicesProtocol) {
    }

    func openNewTaskViewController(storageService storageServices: StorageServicesProtocol) {
    }
}
