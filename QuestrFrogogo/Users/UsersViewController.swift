//
//  ViewController.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit

private enum Cons: String {
    case userCell = "userCell"
}

final class UsersViewController: UIViewController {
    
    private let model = ModelUsersViewController()
    private var users = [User]()
    
    @IBOutlet weak var usersTableView: UITableView! {
        didSet {
            usersTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    private func setupTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.reloadData()
    }
    
    private func getUsers() {
        model.getUsers() { result in
            switch result {
                case .success(let response):
                    self.users = response
                    self.setupTableView()
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cons.userCell.rawValue, for: indexPath) as! UserTableViewCell
        cell.configureCell(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
}

extension UsersViewController: UITableViewDelegate {
    
}
