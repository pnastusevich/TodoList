//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

final class TaskListPresenter: TaskListViewOutputProtocol {
    
    var interactor: TaskListInteractorInputProtocol!
    var router: TaskListRouterInputProtocol!
    
    private unowned let view: TaskListViewInputProtocol
    
    required init(view: TaskListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
}

// MARK: - TaskListInteractorOutputProtocol
extension TaskListPresenter: TaskListInteractorOutputProtocol {
    func taskListDidReceive() {
        
    }
}
