//
//  AddContactsView.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class AddContactsView: UIView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var buttonBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(ColorStore.charcoal.color, for: .normal)
        button.backgroundColor = ColorStore.mercury.color
        return button
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(ColorStore.charcoal.color, for: .normal)
        button.backgroundColor = ColorStore.mercury.color
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = ColorStore.charcoal.color
        addSubviews([tableView, buttonBarView, activityIndicator])
        buttonBarView.addSubviews([cancelButton, okButton])
        let buttonWidth: CGFloat = 70
        let constraints = [
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buttonBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonBarView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            cancelButton.centerXAnchor.constraint(equalTo: buttonBarView.centerXAnchor, constant: buttonWidth),
            cancelButton.centerYAnchor.constraint(equalTo: buttonBarView.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            okButton.centerXAnchor.constraint(equalTo: buttonBarView.centerXAnchor, constant: -buttonWidth),
            okButton.centerYAnchor.constraint(equalTo: buttonBarView.centerYAnchor),
            okButton.widthAnchor.constraint(equalToConstant: buttonWidth),
        ]
        NSLayoutConstraint.activate(constraints)

    }

}

