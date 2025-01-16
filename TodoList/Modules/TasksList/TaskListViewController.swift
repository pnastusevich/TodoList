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

    var presenter: TaskListViewOutputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension TaskListViewController: TaskListViewInputProtocol {
    
}

