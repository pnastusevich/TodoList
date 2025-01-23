//
//  TaskListPresenterTests.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList

final class TaskListPresenterTests: XCTestCase {
    var presenter: TaskListPresenter!
    var mockView: MockTaskListView!
    var mockInteractor: MockTaskListInteractor!
    var mockRouter: MockTaskListRouter!

    override func setUp() {
        super.setUp()

        mockView = MockTaskListView()
        mockRouter = MockTaskListRouter(view: TaskListViewController())
        mockInteractor = MockTaskListInteractor(storageServices: MockStorageServices(mockContext: MockStorageServices.createMockContext()), networkServices: MockNetworkServices(), presenter: MockTaskListPresenter())

        presenter = TaskListPresenter(view: mockView)
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidLoadCallsFetchTaskList() {
        presenter.viewDidLoad()

        XCTAssertTrue(mockInteractor.fetchTaskListCalled)
    }
}
