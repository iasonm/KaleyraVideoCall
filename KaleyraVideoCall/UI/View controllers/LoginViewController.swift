//
//  LoginViewController.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()
    
    override func loadView() {
        loginView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc func okButtonTapped() {
        guard let name = loginView.userNameTextField.text, let password = loginView.passwordTextField.text else {
            showLoginFail()
            return
        }
        loginView.activityIndicator.startAnimating()
        MockApi.login(name: name, password: password) { success in
            self.loginView.activityIndicator.stopAnimating()
            if success {
                Settings.isLogged = true
                self.dismiss(animated: true)
            } else {
                self.showLoginFail()
            }
        }
//        if name.lowercased() == "user" && password == "pass" {
//            Settings.isLogged = true
//            dismiss(animated: true)
//        } else {
//            showLoginFail()
//        }
    }
    
    func showLoginFail() {
        let alert = Alerts.okAlert(title: "Login failed!", message: "Please type 'user' in name field and 'pass' in password field!")
        self.present(alert, animated: true) {
            self.loginView.userNameTextField.text = ""
            self.loginView.passwordTextField.text = ""
        }
    }

}
