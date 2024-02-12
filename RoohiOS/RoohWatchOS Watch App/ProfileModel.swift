//
//  ProfileModel.swift
//  RoohWatchOS Watch App
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation

struct ProfileModel: Codable, Equatable {
    
    private(set) var avatar: ProfileAvatar?
    var age: Double {
        didSet {
            print("age \(age)")
        }
    }
    var height: Double {
        didSet {
            print("height \(height)")
        }
    }
    var weight: Double
    
    init(avatar: ProfileAvatar? = nil, age: Double, height: Double, weight: Double) {
        self.avatar = avatar
        self.age = age
        self.height = height
        self.weight = weight
    }
    
    static func == (lhs: ProfileModel, rhs: ProfileModel) -> Bool {
        if lhs.avatar == rhs.avatar && lhs.age == rhs.age && lhs.height == rhs.height && lhs.weight == rhs.weight {
            return true
        }
        return false
    }
}

struct ProfileAvatar: Codable, Equatable {
    let name: String
    let base64: String
    
    static func == (lhs: ProfileAvatar, rhs: ProfileAvatar) -> Bool {
        lhs.name == rhs.name
    }
}

//extension Int: BinaryFloatingPoint {
//    public typealias RawSignificand = <#type#>
//    
//    public typealias RawExponent = <#type#>
//    
//    public static var exponentBitCount: Int {
//        <#code#>
//    }
//    
//    public static var significandBitCount: Int {
//        <#code#>
//    }
//    
//    public var binade: Int {
//        <#code#>
//    }
//    
//    public var significandWidth: Int {
//        <#code#>
//    }
//    
//    public typealias FloatLiteralType = <#type#>
//    
//    public typealias Exponent = <#type#>
//    
//    
//}
