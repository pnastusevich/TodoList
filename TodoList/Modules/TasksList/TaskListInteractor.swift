//
//  TodoListInteractor.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

protocol TaskListInteractorInputProtocol {
    init(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol, presenter: TaskListInteractorOutputProtocol)
}

protocol TaskListInteractorOutputProtocol: AnyObject {
    func taskListDidReceive()
}


final class TaskListInteractor: TaskListInteractorInputProtocol {
    
    private let storageServices: StorageServicesProtocol
    private let networkServices: NetworkServicesProtocol
    
    private unowned let presenter: TaskListInteractorOutputProtocol
    
    required init(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol, presenter: TaskListInteractorOutputProtocol) {
        self.storageServices = storageServices
        self.networkServices = networkServices
        self.presenter = presenter
    }
    
    
}
