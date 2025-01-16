//
//  TaskListConfigurator.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import UIKit

protocol TaskListConfiguratorInputProtocol {
    func createModule(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol) -> UIViewController
}

final class TaskListConfigurator: TaskListConfiguratorInputProtocol {
    
    func createModule(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol) -> UIViewController {
        
        let view = TaskListViewController()
        let presenter = TaskListPresenter(view: view)
        let interactor = TaskListInteractor(storageServices: storageServices, networkServices: networkServices, presenter: presenter)
        
        let router = TaskListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
