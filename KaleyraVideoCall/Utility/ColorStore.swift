//
//  ColorStore.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

enum ColorStore {
    
    case charcoal, mercury
    
    var color: UIColor {
        switch self {
        case .charcoal: return UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)
        case .mercury: return UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
        
        }
    }
    
}
