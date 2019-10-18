//
//  UserViewController.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    private let model = ModelUserViewController()
    
    var selectedUser: User?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doneBarBtnTap(_ sender: Any) {
        isSelectedUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = selectedUser else { return }
        setupTextFields(user: user)
    }
    
    private func isSelectedUser() {
        if checkEmptyTextFields() {
            if selectedUser == nil {
                guard let newUser = createNewUser() else {
                    showErrorAlertMessadge(title: "Error", messadge: "Oops!")
                    return
                }
                addNewUser(user: newUser)
            } else {
                changeSelectedUser()
            }
        }
    }
    
    private func createNewUser() -> CreateUser? {
        let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespaces)
        let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespaces)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
        if validateName(name: firstName) && validateName(name: lastName) && validateEmail(enteredEmail: email) {
            return CreateUser(first_name: firstName, last_name: lastName, email: email)
        } else {
            return nil
        }
    }
    
    private func setupTextFields(user: User) {
        firstNameTextField.text = user.first_name
        lastNameTextField.text = user.last_name
        emailTextField.text = user.email
    }
    
    private func checkEmptyTextFields() -> Bool {
        if firstNameTextField.text!.trimmingCharacters(in: .whitespaces) == "" || lastNameTextField.text!.trimmingCharacters(in: .whitespaces) == "" && emailTextField.text!.trimmingCharacters(in: .whitespaces) == "" {
            self.showErrorAlertMessadge(title: "Ошибка", messadge: "Заполните все поля!")
            return false
        }
        return true
    }
    
    private func addNewUser(user: CreateUser) {
        model.addNewUser(user: user) { result in
            switch result {
                case .success(_):
                    self.showCompletionAlert() {
                        print("qwert")
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.showErrorAlertMessadge(title: "Ошибка", messadge: "проверьте подключение")
                    } else {
                        self.showErrorAlertMessadge(title: "Ошибка", messadge: error.localizedDescription)
                    }
                    break
            }
        }
    }
    
    private func changeSelectedUser() {
        if firstNameTextField.text! == selectedUser!.first_name && lastNameTextField.text! == selectedUser!.last_name && emailTextField.text! == selectedUser!.email {
            
        } else {
            
        }
    }
    
    private func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    private func validateName(name: String) -> Bool {
       // Length be 18 characters max and 3 characters minimum, you can always modify.
       let nameRegex = "^\\w{3,18}$"
       let trimmedString = name.trimmingCharacters(in: .whitespaces)
       let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
       let isValidateName = validateName.evaluate(with: trimmedString)
       return isValidateName
    }

}
