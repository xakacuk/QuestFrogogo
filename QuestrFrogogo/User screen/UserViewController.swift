//
//  UserViewController.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var selectedUser: User?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doneBarBtnTap(_ sender: Any) {
        isSelectedUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func isSelectedUser() {
        if selectedUser == nil {
            addNewUser()
        } else {
            changeSelectedUser()
        }
    }
    
    private func addNewUser() {
        guard let email = emailTextField.text,
        let firstName = firstNameTextField.text,
        let lastName = lastNameTextField.text else {
            print("qwert")
            return
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
