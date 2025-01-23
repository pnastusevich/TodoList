//
//  ToDoTestTests.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList


final class TaskListInteractorTests: XCTestCase {

    override func setUp()  {
        super.setUp()
        
    }

    override func tearDown()  {
        super.tearDown()
    }

    func testFetchTaskListFromCoreData() {
        let mockContext = MockStorageServices.createMockContext()
        let mockStorageManager = MockStorageServices(mockContext: mockContext)
        let mockPresenter = MockTaskListPresenter()
        let mockNetworkManager = MockNetworkServices()

        let task = Task(context: mockContext)
        task.name = "Core Data Task"
        task.subname = "Task from Core Data"
        task.isCompleted = false
        task.createdAt = Date()
        mockStorageManager.fetchTasksResult = .success([task])
        
        let interactor = TaskListInteractor(
            storageServices: mockStorageManager,
            networkServices: mockNetworkManager,
            presenter: mockPresenter
        )
        interactor.fetchTaskList()
        XCTAssertEqual(mockPresenter.receivedTasks?.tasksList.count, 1)
        XCTAssertEqual(mockPresenter.receivedTasks?.tasksList.first?.name, "Core Data Task")
    }
    
    func testFetchTaskListFromAPIWhenCoreDataIsEmpty() {
        let mockContext = MockStorageServices.createMockContext()
        let mockStorageServices = MockStorageServices(mockContext: mockContext)
        let mockPresenter = MockTaskListPresenter()
        let mockNetworkServices = MockNetworkServices()

        mockStorageServices.fetchTasksResult = .success([])
        mockNetworkServices.fetchResult = .success(TasksInApi(
            todos: [
                Tasks(id: 0, todo: "API Task 1", completed: false, userId: 0),
                Tasks(id: 1, todo: "API Task 2", completed: true, userId: 1)
            ],
            total: 2
        ))

        let interactor = TaskListInteractor(
            storageServices: mockStorageServices,
            networkServices: mockNetworkServices,
            presenter: mockPresenter
        )

        let expectation = self.expectation(description: "Waiting for task list")
        mockPresenter.didReceiveTaskList = {
            expectation.fulfill()
        }
        interactor.fetchTaskList()
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(mockPresenter.receivedTasks?.tasksList.count, 2)
        XCTAssertEqual(mockPresenter.receivedTasks?.tasksList.first?.name, "API Task 1")
    }
    
    func testDoneTaskUpdatesTaskState() {
        let mockContext = MockStorageServices.createMockContext()
        let mockStorageServices = MockStorageServices(mockContext: mockContext)
        let mockPresenter = MockTaskListPresenter()
        let mockNetworkServices = MockNetworkServices()

        let task = Task(context: mockContext)
        task.name = "Task to Complete"
        task.subname = "Pending Task"
        task.isCompleted = false
        task.createdAt = Date()

        mockStorageServices.fetchTasksResult = .success([task])

        let interactor = TaskListInteractor(
            storageServices: mockStorageServices,
            networkServices: mockNetworkServices,
            presenter: mockPresenter
        )

        interactor.doneTask(task: task)

        XCTAssertTrue(task.isCompleted)
        XCTAssertEqual(task.name, "Task to Complete")
    }
    
    func testDeleteTaskRemovesTaskFromCoreData() {
        let mockContext = MockStorageServices.createMockContext()
        let mockStorageServices = MockStorageServices(mockContext: mockContext)
        let mockPresenter = MockTaskListPresenter()
        let mockNetworkServices = MockNetworkServices()

        let task = Task(context: mockContext)
        task.name = "Task to Delete"
        task.subname = "Temporary Task"
        task.isCompleted = false
        task.createdAt = Date()

        mockStorageServices.fetchTasksResult = .success([task])

        let interactor = TaskListInteractor(
            storageServices: mockStorageServices,
            networkServices: mockNetworkServices,
            presenter: mockPresenter
        )
        interactor.deleteTask(task: task)
        XCTAssertEqual(mockStorageServices.deletedTask, task)
    }
}
