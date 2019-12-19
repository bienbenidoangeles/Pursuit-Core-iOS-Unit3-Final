//
//  ElementAPIClent.swift
//  Elements
//
//  Created by Bienbenido Angeles on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    static func getElements(completion: @escaping (Result<[AtomicElement], AppError>) -> ()){
        let endPointURLString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        let urlRequest = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: urlRequest) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let elements = try JSONDecoder().decode([AtomicElement].self, from: data)
                    completion(.success(elements))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postElements(for element: AtomicElement, completion: @escaping (Result<Bool, AppError>)->()){
        let endPointURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONEncoder().encode(element)
            request.httpBody = data
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result{
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        }catch{
            completion(.failure(.encodingError(error)))
        }
    }
    
    static func getFavoritedElements(completion: @escaping (Result<[AtomicElement], AppError>) -> ()){
        let endPointURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        let urlRequest = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: urlRequest) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let elements = try JSONDecoder().decode([AtomicElement].self, from: data)
                    completion(.success(elements))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getRemainingElements(completion: @escaping (Result<[AtomicElement], AppError>) -> ()){
        let endPointURLString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        let urlRequest = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: urlRequest) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let elements = try JSONDecoder().decode([AtomicElement].self, from: data)
                    completion(.success(elements))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
