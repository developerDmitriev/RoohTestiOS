//
//  Errors.swift
//  RoohiOS
//
//  Created by Cezar_ on 12.02.24.
//

import Foundation

public enum Errors: Error {
    case sessionIsntReachable
}

extension Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .sessionIsntReachable:
            return NSLocalizedString("session isn't reachable.", comment: "Errors")
        }
    }
}
