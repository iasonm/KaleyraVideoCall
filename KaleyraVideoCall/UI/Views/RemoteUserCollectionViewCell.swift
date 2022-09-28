//
//  RemoteUserCollectionViewCell.swift
//  KaleyraVideoCall
//
//  Created by Iason Michailidis on 28/9/22.
//

import UIKit

class RemoteUserCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "remoteUserCollectionViewCell"
    
    var stream: Stream? {
        didSet {
            if let contact = contact, let stream = stream {
                nameLabel.text = contact.name
                userImageView.image = stream.hasVideo ? contact.avatar : ImageStore.videoOffIcon.image
            }
        }
    }
    
    var contact: Contact?
    
    var nameLabel: UILabel = {
        let textLabel = UILabel(frame: .zero)
        return textLabel
    }()
    
    var userImageView: UIImageView = UIImageView(image: ImageStore.waveform.image)

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(textLabel)
        contentView.backgroundColor = .white
        let minDimension = min(contentView.bounds.height, contentView.bounds.width) - 5
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: minDimension),
            userImageView.heightAnchor.constraint(equalToConstant: minDimension),
            
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        self.nameLabel = textLabel
        self.nameLabel.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        fatalError("Interface Builder is not supported!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        fatalError("Interface Builder is not supported!")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.nameLabel.text = nil
        self.userImageView.image = nil
    }
}
