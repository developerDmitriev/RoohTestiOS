//
//  AvatarCollectionViewCell.swift
//  RoohiOS
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation
import UIKit

class AvatarCollectionViewCell: UICollectionViewCell, NameDescribable {
    
    let avatarImage: UIImageView = {
        let avatarView = UIImageView()
        avatarView.backgroundColor = .purple
        return avatarView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(image: UIImage?) {
        guard let image = image else { return }
        self.avatarImage.image = image
        self.addSubview(avatarImage)
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        avatarImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo:leadingAnchor).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
    }
    
}
