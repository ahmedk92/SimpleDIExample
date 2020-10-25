//
//  LoginViewController.swift
//  DIExample
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped() {
        viewModel.login(
            withEmail: emailTextField.text!,
            password: passwordTextField.text!
        )
    }
    private let viewModel = LoginViewModel()
    private func bindViewModel() {
        viewModel.showError = { error in
            print(error.localizedDescription)
        }
        viewModel.showMainViewForUser = { user in
            // For example, present MainViewController(user: user).
        }
    }
}
