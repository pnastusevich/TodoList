//
//  FactorySevices.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

protocol StorageServicesProtocolFactory {
    func makeStorageServices() -> StorageServicesProtocol
}

protocol NetworkServicesProtocolFactory {
    func makeNetworkServices() -> NetworkServicesProtocol
}

final class FactoryServices: StorageServicesProtocolFactory, NetworkServicesProtocolFactory {
    
    func makeStorageServices() -> StorageServicesProtocol {
        return StorageServices()
    }
    
    func makeNetworkServices() -> NetworkServicesProtocol {
        return NetworkServices()
    }
}
