//
//  Room.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import Foundation

protocol RoomDelegate {
    
    func didConnect()
    func didDisconnect()
    func didAddStream(_ stream: Stream)
    func didRemoveStream(_ stream: Stream)
    
}

class Room {
    
    let id: Int
    var streams = [Stream]()
    var delegate: RoomDelegate?
    
    private let delay = 800
    
    init(id: Int) {
        self.id = id
    }
    
    func connect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            self.delegate?.didConnect()
        }

    }
    
    func disconnect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            self.delegate?.didDisconnect()
        }
    }
    
    func addStream(user: Contact) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            let rand = Int.random(in: 0...3)
            let hasVideo = rand != 0
            self.delegate?.didAddStream(Stream(userId: user.id, hasAudio: true, hasVideo: hasVideo))
        }

    }
    
    func removeStream(user: Contact) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            if let stream = self.streams.first(where: { $0.userId == user.id }) {
                self.delegate?.didRemoveStream(stream)
            }
        }
    }
    
}

struct Stream {
    
    let userId: Int
    let hasAudio: Bool
    let hasVideo: Bool
    
}
