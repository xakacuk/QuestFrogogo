//
//  HTTPManager.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation
import Alamofire

private enum Path: String {
    case getUsers = "users.json"
}

private enum Const {
    static let url = "https://frogogo-test.herokuapp.com/"
}

private enum Config {
    static let timeout: Double = 15.0
}

public final class HTTPManager {
    
    static let shared = HTTPManager()
    
    public typealias Parameters = [String: Any]
    
    private let decoder = JSONDecoder()
    
    enum Config {
        static let timeout: Double = 15.0
    }
    
    lazy var networkSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = Config.timeout
        configuration.timeoutIntervalForRequest = Config.timeout
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    func getUsers(completionHandler: @escaping (Swift.Result<[User]?, Error>) -> Void) {

        self.networkSessionManager.request("\(Const.url)\(Path.getUsers.rawValue)", method: .get, parameters: nil, headers: nil).validate().responseJSON { [weak self] response in

            guard let sSelf = self else { return }
                
            switch response.result {
                case .success(_):
                    guard let data = response.data else {
                        assertionFailure()
                        return
                    }
                    
                    if let rawString = String(bytes: data, encoding: .utf8) {
                        print(rawString)
                    }
                    
                    do {
                        let users = try sSelf.decoder.decode([User].self, from: data)
                        completionHandler(.success(users))
                    } catch {
                        completionHandler(.failure(ApiErrorCode.other))
                    }
                    
                    break
                
                case .failure(let error):

                    if let httpStatusCode = response.response?.statusCode {

                       switch httpStatusCode {
                            case 422:
                                completionHandler(.failure(ApiErrorCode.code422))
                                break
                            default:
                                completionHandler(.failure(error))
                                break
                        }
                    } else {
                        break
                    }
            }
        }
    }
    
    func createNewUser(user: CreateUser, completionHandler: @escaping (Swift.Result<String?, Error>) -> Void) {
        
        let params: Parameters = [
            "user": [
                "first_name": user.first_name,
                "last_name": user.last_name,
                "email": user.email
            ]
        ]
        
        self.networkSessionManager.request("\(Const.url)\(Path.getUsers.rawValue)", method: .post, parameters: params, headers: nil).validate().responseJSON { response in
            
                switch response.result {
                    case .success(_):
                        guard let data = response.data else {
                            assertionFailure()
                            return
                        }
                        
                        if let rawString = String(bytes: data, encoding: .utf8) {
                            print(rawString)
                        }
                        
                        completionHandler(.success(""))
                        break
                    
                    case .failure(let error):

                        if let httpStatusCode = response.response?.statusCode {

                           switch httpStatusCode {
                                case 422:
                                    completionHandler(.failure(ApiErrorCode.code422))
                                    break
                                default:
                                    completionHandler(.failure(error))
                                    break
                            }
                        } else {
                            break
                        }
                }
            }
        }
    
}
