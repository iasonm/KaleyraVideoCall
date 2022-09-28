//
//  LoginView.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class LoginView: UIView {
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Name"
        return label
    }()
    
    var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name 'user'"
        return textField
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Password"
        return label
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password 'pass'"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(ColorStore.charcoal.color, for: .normal)
        button.backgroundColor = ColorStore.mercury.color
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addSubviews([userNameLabel, userNameTextField, passwordLabel, passwordTextField, okButton, activityIndicator])
        let constraints = [
            userNameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
            userNameLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            userNameLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            userNameTextField.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            userNameTextField.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 12),
            passwordLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            passwordLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            passwordTextField.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            passwordTextField.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            okButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            okButton.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.3),
            okButton.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
