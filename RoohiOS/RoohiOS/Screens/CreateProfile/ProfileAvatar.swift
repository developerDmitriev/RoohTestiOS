//
//  ProfileAvatar.swift
//  RoohiOS
//
//  Created by Cezar_ on 08.02.24.
//

import Foundation

struct ProfileAvatar: Decodable {
    let name: String
    let base64: String
}

struct Images: Decodable {
    let images: [ProfileAvatar]
}
