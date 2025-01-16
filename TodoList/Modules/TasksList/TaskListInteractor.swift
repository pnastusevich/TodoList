//
//  TodoListInteractor.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

protocol TaskListInteractorInputProtocol {
    init(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol, presenter: TaskListInteractorOutputProtocol)
    func fetchTaskList()
    func doneTask(task: Task?)
    func deleteTask(task: Task)
}

protocol TaskListInteractorOutputProtocol: AnyObject {
    func taskListDidReceive(with dataStore: TaskListDataStore)
}


final class TaskListInteractor: TaskListInteractorInputProtocol {
    
    private let storageServices: StorageServicesProtocol
    private let networkServices: NetworkServicesProtocol
    
    private unowned let presenter: TaskListInteractorOutputProtocol
    
    private var isFetchingFromAPI = false
    
    required init(storageServices: StorageServicesProtocol, networkServices: NetworkServicesProtocol, presenter: TaskListInteractorOutputProtocol) {
        self.storageServices = storageServices
        self.networkServices = networkServices
        self.presenter = presenter
    }
    
    func fetchTaskList() {
        storageServices.fetchDataTask { [weak self]
            result in
            switch result {
            case .success(let taskList):
                if taskList.isEmpty {
                    if !self!.isFetchingFromAPI {
                        self!.isFetchingFromAPI = true
                        self!.fetchTasksFromAPI()
                    }
                } else {
                    let dataStore = TaskListDataStore(tasksList: taskList)
                    self?.presenter.taskListDidReceive(with: dataStore)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTasksFromAPI() {
        networkServices.fetchData { [weak self] result in
            switch result {
            case .success(let taskList):
                var newTasks: [Task] = []
                let currentDate = Date()
                
                let group = DispatchGroup()
                
                for task in taskList.todos {
                    group.enter()
                    self?.storageServices.createTask(taskName: task.todo, description: "Нет описания у задачи, которая была получена из API", createdDate: currentDate, isCompleted: task.completed) { task in
                        newTasks.append(task)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    let dataStore = TaskListDataStore(tasksList: newTasks)
                    self?.presenter.taskListDidReceive(with: dataStore)
                }
            case .failure(let error):
                print("\(error.localizedDescription) ошибка в fetchTasksFromAPI")
            }
        }
    }
    
    func doneTask(task: Task?) {
        guard let task = task else { return }
        storageServices.doneTask(task: task)
        fetchTaskList()
    }
    func deleteTask(task: Task) {
        storageServices.deleteTask(task: task)
        fetchTaskList()
    }
}
