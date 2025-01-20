//
//  TaskDetailsInteractor.swift
//  ToDoTest
//
//  Created by Паша Настусевич on 21.11.24.
//

import Foundation

protocol TaskDetailsInteractorInputProtocol {
    init(presenter: TaskDetailsInteractorOutputProtocol, task: Task?, storageService: StorageServicesProtocol)
    
    func loadTask() -> Task?
    func saveTask(name: String, description: String, date: Date)
}

protocol TaskDetailsInteractorOutputProtocol: AnyObject {
    func newSavedTaskDidReceived(with newTask: Task)
}

final class TaskDetailsInteractor: TaskDetailsInteractorInputProtocol {
        
    private unowned let presenter: TaskDetailsInteractorOutputProtocol
    private var task: Task?
    private let storageService: StorageServicesProtocol
    
   
    init(presenter: TaskDetailsInteractorOutputProtocol, task: Task? = nil, storageService: StorageServicesProtocol) {
        self.presenter = presenter
        self.task = task
        self.storageService = storageService
    }
    
    func loadTask() -> Task? {
        return task
    }
    
    func saveTask(name: String, description: String, date: Date) {
        if let task = task {
            task.name = name
            task.subname = description
            task.createdAt = date
            storageService.updateTask(task: task,
                                      taskName: name,
                                      description: description,
                                      createdDate: date,
                                      isCompleted: false
            )
        } else {
            storageService.createTask(taskName: name,
                                      description: description,
                                      createdDate: date,
                                      isCompleted: false
            ) { newTask in
                self.presenter.newSavedTaskDidReceived(with: newTask)
            }
        }
    }
}
