//
//  Contact.swift
//  KaleyraTest
//
//  Created by Iason Michailidis on 26/9/22.
//

import Foundation
import UIKit

struct Contact {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: UIImage
    
    var name: String {
        return "\(firstName) \(lastName)"
    }
}

extension Contact {
    
    static var contactList: [Contact] {
        return [
            Contact(id: 1, firstName: "One", lastName: "First", avatar: UIImage(named: "24")!),
            Contact(id: 2, firstName: "Two", lastName: "Second", avatar: UIImage(named: "31")!),
            Contact(id: 3, firstName: "Three", lastName: "Third", avatar: UIImage(named: "37")!),
            Contact(id: 4, firstName: "Four", lastName: "Fourth", avatar: UIImage(named: "58")!),
            Contact(id: 5, firstName: "Five", lastName: "Fifth", avatar: UIImage(named: "80")!),
            Contact(id: 6, firstName: "Six", lastName: "Sixth", avatar: UIImage(named: "80b")!),
            Contact(id: 7, firstName: "Seven", lastName: "Seventh", avatar: UIImage(named: "92")!),
            Contact(id: 8, firstName: "Eight", lastName: "Eighth", avatar: UIImage(named: "92b")!),
        ]
    }
    
    static var userContacts: [Contact] {
        get {
            let ids = UserDefaults.standard.object(forKey: "userContactIds") as? [Int] ?? []
            var contacts = [Contact]()
            for contact in Contact.contactList {
                if ids.contains(contact.id) {
                    contacts.append(contact)
                }
            }
            return contacts
        }
        set {
            let ids = newValue.map { $0.id }
            UserDefaults.standard.set(ids, forKey: "userContactIds")
        }
        
    }

}

