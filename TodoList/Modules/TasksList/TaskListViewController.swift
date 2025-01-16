//
//  ViewController.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import UIKit

protocol TaskListViewInputProtocol: AnyObject {
    
}

protocol TaskListViewOutputProtocol: AnyObject {
    
}

final class TaskListViewController: UIViewController {

    let networkService = NetworkServices()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        networkService.fetchData { result in
            switch result {
            case .success(let data):
                print(data.total)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TaskListViewController: TaskListViewInputProtocol {
    
}

