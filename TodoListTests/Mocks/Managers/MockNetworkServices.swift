//
//  MockNetworkManager.swift
//  TodoListTests
//
//  Created by Паша Настусевич on 23.01.25.
//

import XCTest
@testable import TodoList

final class MockNetworkServices: NetworkServicesProtocol {
    var fetchResult: Result<TasksInApi, NetworkError> = .success(TasksInApi(todos: [], total: 0))

    func fetchData(completion: @escaping (Result<TasksInApi, NetworkError>) -> Void) {
        completion(fetchResult)
    }
}
