//
//  NetworkServices.swift
//  TodoList
//
//  Created by Паша Настусевич on 16.01.25.
//

import Foundation

protocol NetworkServicesProtocol {
    func fetchData(completion: @escaping (Result<TasksInApi, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkServices: NetworkServicesProtocol {
    func fetchData(completion: @escaping (Result<TasksInApi, NetworkError>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            do {
                let todoInApi = try JSONDecoder().decode(TasksInApi.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(todoInApi))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
