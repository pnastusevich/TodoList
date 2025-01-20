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
    
    func editTask(with task: TaskCellViewModelProtocol) {
//        router.openTaskDetailsViewController(with: task.task, storageManager: interactor.giveStorageManager())
    }
    
    func shareTask(with task: TaskCellViewModelProtocol) {
        print("share task")
    }
    
    func deleteTask(with task: TaskCellViewModelProtocol) {
        interactor.deleteTask(task: task.task)
    }
    
    func didTapAddTaskButton() {
//        router.openNewTaskViewController(storageManager: interactor.giveStorageManager())
    }
    
    func doneTasks(at index: Int) {
        //
    }
    
    func updateTask(_ task: Task) {
        view.reloadData(for: dataStore!.section)
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
