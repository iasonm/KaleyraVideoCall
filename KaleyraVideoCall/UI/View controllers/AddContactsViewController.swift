//
//  AddContactsViewController.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class AddContactsViewController: UIViewController  {
    
    var okTappedAction: (([Contact]) -> Void)?
    
    var contacts = [Contact]()
    var selectedContacts: [Contact] {
        var selectedContacts = [Contact]()
        for selection in selectedContactIds {
            if selection.value, let selectedContact = contacts.first(where: {$0.id  == selection.key}) {
                selectedContacts.append(selectedContact)
            }
        }
        return selectedContacts
    }
    var selectedContactIds = [Int : Bool]()
    
    var addContactsView = AddContactsView()
    
    var tableView: UITableView {
        return addContactsView.tableView
    }
       
    override func loadView() {
        addContactsView.tableView.dataSource = self
        addContactsView.tableView.delegate = self
        addContactsView.okButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        addContactsView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        view = addContactsView
    }
    
    @objc func okTapped() {
        okTappedAction?(selectedContacts)
        dismiss(animated: true)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(view.subviews)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(view.subviews)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addContactsView.activityIndicator.startAnimating()
        MockApi.requestAvailableContacts { contacts in
            self.contacts = contacts
            self.tableView.reloadData()
            self.addContactsView.activityIndicator.stopAnimating()
        }
    }

}

extension AddContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = contact.name
        cell.imageView?.image = contact.avatar
        cell.accessoryType = selectedContactIds[contact.id] ?? false ? .checkmark : .none
        return cell
    }
    

    
}

extension AddContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let id = contacts[indexPath.row].id
        if selectedContactIds[id] ?? false {
            selectedContactIds[id] = false
        } else {
            selectedContactIds[id] = true
        }
        tableView.reloadData()
    }
    
}
