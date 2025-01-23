//
//  MockTaskListView.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList

final class MockTaskListView: TaskListViewInputProtocol {
    var reloadDataCalled = false
    var section: TaskSectionViewModel?

    func reloadData(for section: TaskSectionViewModel) {
        reloadDataCalled = true
        self.section = section
    }
}
