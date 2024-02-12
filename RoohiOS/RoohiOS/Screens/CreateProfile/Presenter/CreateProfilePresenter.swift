//
//  CreateProfilePresenter.swift
//  RoohiOS
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation

class CreateProfilePresenter {
    let watchConnectionProvider = WatchConnectivityProvider()
    
    weak var view: CreateProfileViewController?

    var isFilledProfileModel = false {
        didSet {
            if isFilledProfileModel {
                view?.updateButtonState(isActive: isFilledProfileModel)
            }
        }
    }
    
    var profileModel = CreateProfileModel() {
        didSet {
           // print(profileModel)
            isFilledProfileModel = profileModel.isFilled()
        }
    }
    var avatars = [ProfileAvatar]() {
        didSet {
            view?.updateAvatars(with: avatars)
        }
    }
    
    init(view: CreateProfileViewController? = nil) {
        self.view = view
        watchConnectionProvider.connect()
    }
    
    func fetchAvatars(){
        let _ = AvatarServiceLocal.shared.fetchAvatars { [weak self] result in
            switch result {
            case .success(let images):
                self?.avatars.append(contentsOf: images.images)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func updateProfileModel(avatar: ProfileAvatar) {
        profileModel.update(avatar: avatar)
    }
    
    func updateProfileModel(age: Int) {
        profileModel.update(age: age)
    }
    
    func updateProfileModel(height: Int) {
        profileModel.update(height: height)
    }
    
    func updateProfileModel(weight: Double) {
        profileModel.update(weight: weight)
    }
    
    func updateProfileModel(model: CreateProfileModel) {
        profileModel = model
    }
    
    func sendDataToWatch() {
        guard let data = try? JSONEncoder().encode(profileModel) else {return}
        watchConnectionProvider.sendMessageData(with: data)
    }
    
    func handleReceivedMessageData(_ messageData: Data) {
        do {
            // Decode the received data into the model structure
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CreateProfileModel.self, from: messageData)
            
            // Now you can use the decoded data as per your application's requirements
            print("Received decoded data - Name: \(String(describing: decodedData.avatar?.name)))")
            
        } catch {
            print("Error decoding received message data: \(error.localizedDescription)")
        }
    }
}
