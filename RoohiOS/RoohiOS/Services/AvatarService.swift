//
//  AvatarService.swift
//  RoohiOS
//
//  Created by Cezar_ on 08.02.24.
//

import Foundation

protocol AvatarServiceProtocol {
    func fetchAvatars(completion: @escaping (Result<Images, Error>) -> Void)
}

class AvatarServiceLocal: AvatarServiceProtocol {
    static let shared: AvatarServiceProtocol = AvatarServiceLocal()
    
    private init() {}
    
    func fetchAvatars(completion: @escaping (Result<Images, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: Constants.fileName, ofType: Constants.fileType) else {
            completion(.failure(Errors.cantFindFile(name: Constants.fileName)))
            return
        }
        do {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                completion(.failure(Errors.invalidData))
                return
            }
            guard let images = try? JSONDecoder().decode(Images.self, from: data) else {
                completion(.failure(Errors.cantDecodeData))
                return
            }
            completion(.success(images))
        }
    }
}

private extension AvatarServiceLocal {
    enum Constants {
        static let fileName: String = "ImagesArray"
        static let fileType = "json"
    }
    
    enum Errors: Error {
        case invalidData
        case cantDecodeData
        case invalidPath
        case cantFindFile(name: String)
    }
}
