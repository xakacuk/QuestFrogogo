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
    case userSegue = "userSegue"
}

final class UsersViewController: UIViewController {
    
    private let model = ModelUsersViewController()
    private var users = [User]()
    private var selectedUser: User?
    private var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var usersTableView: UITableView! {
        didSet {
            usersTableView.tableFooterView = UIView()
        }
    }
    
    @IBAction func addNewUserBarBtnTap(_ sender: Any) {
        performSegue(withIdentifier: Cons.userSegue.rawValue, sender: self)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        getUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        self.setupTableView()
        getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedUser = nil
    }
    
    private func setupTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.refreshControl = refreshControl
        
    }
    
    private func setupRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        getUsers()
    }
    
    private func getUsers() {
        refreshControl.beginRefreshing()
        model.getUsers() { result in
            switch result {
                case .success(let response):
                    self.users = response
                    self.usersTableView.reloadData()
                    self.refreshControl.endRefreshing()
                    break
                case .failure(let error):
                    self.refreshControl.endRefreshing()
                    if error._code == NSURLErrorTimedOut {
                        self.showErrorAlertMessadge(title: "Ошибка", messadge: "проверьте подключение")
                    } else {
                        self.showErrorAlertMessadge(title: "Ошибка", messadge: error.localizedDescription)
                    }
                    break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Cons.userSegue.rawValue {
            let vc = segue.destination as! UserViewController
            vc.selectedUser = selectedUser
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cons.userCell.rawValue, for: indexPath) as! UserTableViewCell
        cell.avatarImageView.image = nil
        cell.configureCell(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        selectedUser = users[indexPath.row]
        performSegue(withIdentifier: Cons.userSegue.rawValue, sender: self)
    }
}
