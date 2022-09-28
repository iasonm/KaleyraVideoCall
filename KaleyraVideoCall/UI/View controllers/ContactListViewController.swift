//
//  ContactListViewController.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class ContactListViewController: UIViewController {
    
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

    var contactListView = ContactListView()
    var tableView: UITableView {
        return contactListView.tableView
    }
    
    override func loadView() {
        contactListView.tableView.dataSource = self
        contactListView.tableView.delegate = self
        view = contactListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    func configureNavBar() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let user = UIBarButtonItem(image: ImageStore.personCircle.image, style: .plain, target: self, action: #selector(showLogoutDialog))
        navigationItem.leftBarButtonItems = [add, user]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: ImageStore.callIcon.image, style: .plain, target: self, action: #selector(callTapped))
    }
    
    func loadContacts() {
        contactListView.activityIndicator.startAnimating()
        MockApi.requestUserContacts { contacts in
            self.contacts = contacts
            self.tableView.reloadData()
            self.contactListView.activityIndicator.stopAnimating()
        }
    }
    
    func checkLogin() {
        if !Settings.isLogged {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            loadContacts()
        }
    }
    
    @objc func showLogoutDialog() {
        let alert = Alerts.okCancelAlert(title: "Logout?", message: "Are you sure you want to logout?") {
            self.contactListView.activityIndicator.startAnimating()
            MockApi.logout { success in
                if success {
                    self.contactListView.activityIndicator.stopAnimating()
                    Settings.isLogged = false
                    self.contacts = []
                    self.tableView.reloadData()
                    self.checkLogin()                    
                }
            }
            
        }
        present(alert, animated: true)
    }
    
    @objc func addTapped() {
        let vc = AddContactsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.okTappedAction = { selectedContacts in
            self.contactListView.activityIndicator.startAnimating()
            MockApi.addUserContacts(selectedContacts) { userContacts in
                self.contacts = userContacts
                self.tableView.reloadData()
                self.contactListView.activityIndicator.stopAnimating()
            }
        }
        present(vc, animated: true)
    }
    
    @objc func callTapped() {
        guard !selectedContacts.isEmpty else { return }
        let vc = ConversationViewController()
        vc.contacts = selectedContacts
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = contact.name
        cell.imageView?.image = contact.avatar
        cell.accessoryType = selectedContactIds[contact.id] ?? false ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = contacts[indexPath.row]
            contactListView.activityIndicator.startAnimating()
            MockApi.removeUserContact(contact) { contacts in
                print(contacts)
                self.contacts = contacts
                self.tableView.reloadData()
                self.contactListView.activityIndicator.stopAnimating()
            }
        }
    }
}

extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let id = contacts[indexPath.row].id
        if selectedContactIds[id] ?? false {
            selectedContactIds[id] = false
        } else {
            if selectedContacts.count == 4 {
                let alert = Alerts.okAlert(title: "Maximum contacts", message: "You cannot select more than four contacts. Please deselect one before selecting another.")
                present(alert, animated: true)
            } else {
                selectedContactIds[id] = true
            }
        }
        tableView.reloadData()
    }
    
}
