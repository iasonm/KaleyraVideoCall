//
//  ConversationView.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class ConversationView: UIView {

    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var toolbarView = UIView()
    var toolbarStackView = UIStackView()
    var hangUpButton: RoundButton = {
        let button = RoundButton()
        button.setTitle("", for: .normal)
        button.setImage(ImageStore.phoneDownIcon.image, for: .normal)
        return button
    }()
    var muteButton: RoundButton = {
        let button = RoundButton()
        button.setTitle("", for: .normal)
        button.setImage(ImageStore.micIcon.image, for: .normal)
        return button
    }()
    var cameraOnButton: RoundButton = {
        let button = RoundButton()
        button.setTitle("", for: .normal)
        button.setImage(ImageStore.videoIcon.image, for: .normal)
        return button
    }()
    var cameraView = CameraView()
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews([collectionView, toolbarView, toolbarStackView, cameraView, activityIndicator])
        toolbarView.addSubviews([toolbarStackView])
        toolbarStackView.addSubviews([hangUpButton, muteButton, cameraOnButton])
        
        toolbarView.backgroundColor = .white
        
        toolbarStackView.addArrangedSubview(hangUpButton)
        toolbarStackView.addArrangedSubview(muteButton)
        toolbarStackView.addArrangedSubview(cameraOnButton)
        toolbarStackView.backgroundColor = .white
        toolbarStackView.axis = .horizontal
        toolbarStackView.alignment = .center
        toolbarStackView.distribution = .equalSpacing
        toolbarStackView.spacing = 10
        
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.register(RemoteUserCollectionViewCell.self, forCellWithReuseIdentifier: RemoteUserCollectionViewCell.identifier)
        
        cameraView.layer.cornerRadius = 10
        cameraView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            toolbarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            toolbarView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.16),
            toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            toolbarStackView.centerXAnchor.constraint(equalTo: toolbarView.centerXAnchor),
            toolbarStackView.centerYAnchor.constraint(equalTo: toolbarView.centerYAnchor),
            toolbarStackView.widthAnchor.constraint(equalTo: toolbarView.widthAnchor, multiplier: 0.8),
            toolbarStackView.heightAnchor.constraint(equalTo: toolbarView.heightAnchor),
            
            hangUpButton.heightAnchor.constraint(equalTo: toolbarStackView.heightAnchor, multiplier: 0.5),
            hangUpButton.widthAnchor.constraint(equalTo: toolbarStackView.heightAnchor, multiplier: 0.5),
            
            muteButton.heightAnchor.constraint(equalTo: toolbarStackView.heightAnchor, multiplier: 0.5),
            muteButton.widthAnchor.constraint(equalTo: toolbarStackView.heightAnchor, multiplier: 0.5),
            
            cameraOnButton.heightAnchor.constraint(equalTo: toolbarStackView.heightAnchor, multiplier: 0.5),
            cameraOnButton.widthAnchor.constraint(equalTo: toolbarStackView.heightAnchor, multiplier: 0.5),
            
            collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: toolbarView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cameraView.heightAnchor.constraint(equalTo: toolbarView.heightAnchor, multiplier: 0.8),
            cameraView.widthAnchor.constraint(equalTo: toolbarView.heightAnchor, multiplier: 0.8),
            cameraView.bottomAnchor.constraint(equalTo: toolbarView.topAnchor, constant: -12),
            cameraView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -12),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
