//
//  Settings.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import Foundation

struct Settings {
    
    static var isLogged: Bool {
        get {
            UserDefaults.standard.bool(forKey: "UserLoggedIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserLoggedIn")
        }
    }
    
}

