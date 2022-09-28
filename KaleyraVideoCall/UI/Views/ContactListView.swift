//
//  ContactListView.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class ContactListView: UIView {
    
    var tableView = UITableView()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addSubviews([tableView, activityIndicator])
        let constraints = [
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)

    }

}
