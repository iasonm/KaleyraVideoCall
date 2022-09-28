//
//  ImageStore.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

enum ImageStore {
    
    case callIcon, personCircle, phoneDownIcon, videoIcon, micIcon, micSlashIcon, videoOffIcon, waveform
    
    var image: UIImage {
        switch self {
        case .callIcon: return UIImage(named: "callIcon2")!
        case .personCircle: return UIImage(named: "personCircle")!
        case .phoneDownIcon: return UIImage(named: "phoneDownIcon")!
        case .videoIcon: return UIImage(named: "videoIcon")!
        case .micIcon: return UIImage(named: "micIcon")!
        case .micSlashIcon: return UIImage(named: "micSlashIcon")!
        case .videoOffIcon: return UIImage(named: "videoSlashIcon")!
        case .waveform: return UIImage(named: "waveform")!
        }
    }
    
}
