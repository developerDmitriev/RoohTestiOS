//
//  CreateProfileModel.swift
//  RoohiOS
//
//  Created by Cezar_ on 08.02.24.
//

import Foundation

struct CreateProfileModel: Codable {
    private(set) var avatar: ProfileAvatar?
    private(set) var age: Int?
    private(set) var height: Int?
    private(set) var weight: Double?
    
    init(avatar: ProfileAvatar? = nil, age: Int? = nil, height: Int? = nil, weight: Double? = nil) {
        self.avatar = avatar
        self.age = age
        self.height = height
        self.weight = weight
    }
    
    mutating func update(avatar: ProfileAvatar? = nil, age: Int? = nil, height: Int? = nil, weight: Double? = nil) {
        self.avatar = avatar ?? self.avatar
        self.age = age ?? self.age
        self.height = height ?? self.height
        self.weight = weight ?? self.weight
    }
    
    func isFilled() -> Bool {
        return avatar != nil && age != nil && height != nil && weight != nil
    }
}


