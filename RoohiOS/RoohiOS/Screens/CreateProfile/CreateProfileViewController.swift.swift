//
//  CreateProfileViewController.swift
//  RoohiOS
//
//  Created by Cezar_ on 08.02.24.
//

import UIKit

class CreateProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        let _ = AvatarServiceLocal.shared.fetchAvatars { result in
            switch result {
            case .success(let images):
                print(images)
            case .failure(let failure):
                print(failure)
            }
        }
    }


}

