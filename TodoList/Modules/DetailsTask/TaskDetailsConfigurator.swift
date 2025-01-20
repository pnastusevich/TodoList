//
//  TaskDetailsConfigurator.swift
//  ToDoTest
//
//  Created by Паша Настусевич on 21.11.24.
//

import Foundation

protocol TaskDetailsConfiguratorInputProtocol {
    func configureDetailTask(withView view: TaskDetailsViewController, and task: Task, and storageService: StorageServicesProtocol)
    func configureNewTask(withView view: TaskDetailsViewController, and storageService: StorageServicesProtocol)
}

final class TaskDetailsConfigurator: TaskDetailsConfiguratorInputProtocol {
    
    func configureNewTask(withView view: TaskDetailsViewController, and storageService: StorageServicesProtocol) {
        let presenter = TaskDetailsPresenter(view: view)
        let interactor = TaskDetailsInteractor(presenter: presenter, storageService: storageService)
        view.presenter = presenter
        presenter.interactor = interactor
    }
    
    func configureDetailTask(withView view: TaskDetailsViewController, and task: Task, and storageService: StorageServicesProtocol) {
        let presenter = TaskDetailsPresenter(view: view)
    
        let interactor = TaskDetailsInteractor(presenter: presenter, task: task, storageService: storageService)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
