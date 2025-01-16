//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let dependenciesFactory = FactoryServices()
    private let configurator: TaskListConfiguratorInputProtocol = TaskListConfigurator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storageServices = dependenciesFactory.makeStorageServices()
        let networkServices = dependenciesFactory.makeNetworkServices()
        
        let taskListModule = configurator.createModule(
            storageServices: storageServices,
            networkServices: networkServices
        )
        
        let navigationController = UINavigationController(rootViewController: taskListModule)
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let storageService = dependenciesFactory.makeStorageServices()
        storageService.saveContext()
    }


}

