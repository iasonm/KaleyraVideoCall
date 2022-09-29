//
//  ConversationViewController.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class ConversationViewController: UIViewController {
    
    var callEnded: (() -> Void)?
    
    var contacts = [Contact]()
    var room: Room?
    
    var muted = false
    var videoOn = true
   
    var conversationView = ConversationView()
    
    override func loadView() {
        super.loadView()
        conversationView.collectionView.dataSource = self
        conversationView.collectionView.delegate = self
        view = conversationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conversationView.activityIndicator.startAnimating()
        MockApi.connectToRoom { room in
            self.conversationView.activityIndicator.stopAnimating()
            room.delegate = self
            room.connect()
            self.room = room
        }
        conversationView.cameraView.createSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    func configureButtons() {
        conversationView.hangUpButton.addTarget(self, action: #selector(hangUpButtonTapped), for: .touchUpInside)
        conversationView.muteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
        conversationView.cameraOnButton.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
    }
    
    @objc func hangUpButtonTapped() {
        room?.disconnect()
        callEnded?()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func muteButtonTapped() {
        if muted {
            conversationView.muteButton.setImage(ImageStore.micIcon.image, for: .normal)
        } else {
            conversationView.muteButton.setImage(ImageStore.micSlashIcon.image, for: .normal)
        }
        muted.toggle()
    }
    
    @objc func videoButtonTapped() {
        if videoOn {
            conversationView.cameraOnButton.setImage(ImageStore.videoOffIcon.image, for: .normal)
        } else {
            conversationView.cameraOnButton.setImage(ImageStore.videoIcon.image, for: .normal)
        }
        videoOn.toggle()
    }

}

extension ConversationViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contact = contacts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemoteUserCollectionViewCell.identifier, for: indexPath) as! RemoteUserCollectionViewCell
        cell.contact = contact
        return cell
    }
}

extension ConversationViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

extension ConversationViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.size.width
        let collectionHeight = collectionView.bounds.size.height
        let participantNo = contacts.count
        let margin: CGFloat = 2
        if participantNo == 1 {
            return CGSize(width: collectionWidth - margin, height: collectionHeight - margin )
        }
        if participantNo == 2 {
            return CGSize(width: collectionWidth - margin, height: collectionHeight / 2 - margin )
        }
        if participantNo == 3 {
            return CGSize(width: collectionWidth - margin, height: collectionHeight / 3 - margin )

        }
        return CGSize(width: (collectionWidth / 2) - margin, height: (collectionHeight / 2) - margin )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = 0
        return UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin)
    }
}

extension ConversationViewController: RoomDelegate {
    
    func didConnect() {
        print("didConnect")
        for contact in contacts {
            room?.addStream(user: contact)
        }
    }
    
    func didDisconnect() {
        print("didDisconnect")
    }
    
    func didAddStream(_ stream: Stream) {
        print(stream)
        for (idx, contact) in contacts.enumerated() {
            if contact.id == stream.userId, let cell = conversationView.collectionView.cellForItem(at: IndexPath(row: idx, section: 0)) as? RemoteUserCollectionViewCell {
                cell.stream = stream
            }
        }
    }
    
    func didRemoveStream(_ stream: Stream) {
        print(stream)
    }
    
}
