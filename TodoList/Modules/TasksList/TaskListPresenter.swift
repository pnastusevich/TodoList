//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

struct TaskListDataStore {
    var tasksList: [Task]
    let section = TaskSectionViewModel()
}

final class TaskListPresenter: TaskListViewOutputProtocol {
    
    
    
    var interactor: TaskListInteractorInputProtocol!
    var router: TaskListRouterInputProtocol!
    
    private unowned let view: TaskListViewInputProtocol
    private var dataStore: TaskListDataStore?
    var sectionViewModel: TaskSectionViewModelProtocol = TaskSectionViewModel()
    
    required init(view: TaskListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchTaskList()
    }
    
    func didTapAddTaskButton() {
        
    }
}

// MARK: - TaskListInteractorOutputProtocol
extension TaskListPresenter: TaskListInteractorOutputProtocol {
    func taskListDidReceive(with dataStore: TaskListDataStore) {
        self.dataStore = dataStore
        
        for task in dataStore.tasksList {
            let tasksCellViewModel = TaskCellViewModel(tasksList: task)
            dataStore.section.rows.append(tasksCellViewModel)
        }
        view.reloadData(for: dataStore.section)
    }
    
 
}
