//
//  MockApi.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

struct MockApi {
    
    static private let delay = 800
    static private let name = "user"
    static private let password = "pass"
    
    static func requestAllContacts(completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            completion(Contact.contactList)
        }
    }
    
    static func requestAvailableContacts(completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            var availableContacts = [Contact]()
            for contact in Contact.contactList {
                if !Contact.userContacts.contains(where: {$0.id == contact.id}) {
                    availableContacts.append(contact)
                }
            }
            completion(availableContacts)
        }
    }
    
    static func requestUserContacts(completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            completion(Contact.userContacts)
        }
    }
    
    static func addUserContacts(_ contacts: [Contact], completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            var userContacts = Contact.userContacts
            userContacts.append(contentsOf: contacts)
            Contact.userContacts = userContacts
            completion(userContacts)
        }
    }
    
    static func removeUserContact(_ contact: Contact, completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            let userContacts = Contact.userContacts
            let newContacts = userContacts.filter { $0.id != contact.id}
            Contact.userContacts = newContacts
            completion(Contact.userContacts)
        }
    }
    
    static func login(name: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            completion(name.lowercased() == self.name && password.lowercased() == self.password)
        }
    }
    
    static func logout(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            completion(true)
        }
    }
    
    static func connectToRoom(completion: @escaping (Room) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            let room = Room(id: 1)
            completion(room)
        }
    }
    
    
}
