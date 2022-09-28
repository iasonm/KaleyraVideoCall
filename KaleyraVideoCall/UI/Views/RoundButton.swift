//
//  RoundButton.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class RoundButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        backgroundColor = UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1.00)
    }

}
