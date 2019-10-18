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
    case selectedUserSegue = "selectedUserSegue"
}

final class UsersViewController: UIViewController {
    
    private let model = ModelUsersViewController()
    private var users = [User]()
    private var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var usersTableView: UITableView! {
        didSet {
            usersTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        getUsers()
    }
    
    private func setupTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.reloadData()
    }
    
    private func setupRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        usersTableView.refreshControl = refreshControl
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
                    self.setupTableView()
                    self.refreshControl.endRefreshing()
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreshControl.endRefreshing()
                    break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Cons.selectedUserSegue.rawValue {
//            let controller = segue.destination as! FullImageViewController
//            controller.wallpaper = selectedImage
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
        performSegue(withIdentifier: Cons.selectedUserSegue.rawValue, sender: self)
    }
}
