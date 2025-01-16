//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

final class TaskListPresenter: TaskListViewOutputProtocol {
    
    var interactor: TaskListInteractorInputProtocol!
    
}

extension TaskListPresenter: TaskListInteractorOutputProtocol {
    
}
