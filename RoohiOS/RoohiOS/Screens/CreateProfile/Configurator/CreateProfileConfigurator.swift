//
//  CreateProfileConfigurator.swift
//  RoohiOS
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation
import UIKit

final class CreateProfileConfigurator {
    func configure() -> UIViewController {
        let view = CreateProfileViewController()
        let presenter = CreateProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
