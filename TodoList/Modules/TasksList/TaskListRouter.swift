//
//  TodoListRouter.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import UIKit

protocol TaskListRouterInputProtocol {
    init(view: TaskListViewController)
    func openTaskDetailsViewController(with task: Task, storageService: StorageServicesProtocol)
    func openNewTaskViewController(storageService: StorageServicesProtocol)
}

final class TaskListRouter: TaskListRouterInputProtocol {
    private unowned let view: TaskListViewController
    
    required init(view: TaskListViewController) {
        self.view = view
    }
    
    // MARK: - Open Detail Task
    func openTaskDetailsViewController(with task: Task, storageService: StorageServicesProtocol) {
        let taskDetailsVC = TaskDetailsViewController()
                  
        let configurator: TaskDetailsConfiguratorInputProtocol = TaskDetailsConfigurator()
        configurator.configureDetailTask(withView: taskDetailsVC, and: task, and: storageService)
        
        taskDetailsVC.updateDataTaskList = { [weak self] in
            self?.view.reloadData()
        }
              
        if view.navigationController == nil {
            let navController = UINavigationController(rootViewController: view)
            view.present(navController, animated: true) {
                navController.pushViewController(taskDetailsVC, animated: true)
            }
        } else {
            view.navigationController?.pushViewController(taskDetailsVC, animated: true)
        }
    }
    
    // MARK: - Open New Task
    func openNewTaskViewController(storageService: StorageServicesProtocol) {
        let taskDetailsVC = TaskDetailsViewController()
                  
        let configurator: TaskDetailsConfiguratorInputProtocol = TaskDetailsConfigurator()
        configurator.configureNewTask(withView: taskDetailsVC, and: storageService)
        
        taskDetailsVC.updateDataTaskList = { [weak self] in
            self?.view.reloadData()
        }
        
        if view.navigationController == nil {
            let navController = UINavigationController(rootViewController: view)
            view.present(navController, animated: true) {
                navController.pushViewController(taskDetailsVC, animated: true)
            }
        } else {
            view.navigationController?.pushViewController(taskDetailsVC, animated: true)
        }
    }
}
    



