//
//  TodoListRouter.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import UIKit

protocol TaskListRouterInputProtocol {
    init(view: TaskListViewController)

}

final class TaskListRouter: TaskListRouterInputProtocol {
    
    private unowned let view: TaskListViewController
    
    required init(view: TaskListViewController) {
        self.view = view
    }
}

