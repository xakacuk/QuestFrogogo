//
//  ModelUserViewController.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation

final class ModelUserViewController {
    
    private let httpManager = HTTPManager.shared
    
    func changeUser(completion: @escaping (Swift.Result<User, Error>) -> Void) {
        
    }
    
    func addNewUser(user: CreateUser, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        httpManager.createNewUser(user: user) { result in
            switch result {
                case .success(let response):
                    guard let res = response else { return }
                    completion(.success(res))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
}
