//
//  WarningViewController.swift
//  RoohiOS
//
//  Created by Cezar_ on 12.02.24.
//

import Foundation
import UIKit

class WarningViewController: UIViewController {
    let warningDescription: String
    
    lazy private var warningDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = warningDescription
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        return label
    }()
    
    init(warningDescription: String) {
        self.warningDescription = warningDescription
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(warningDescriptionLabel)
        self.view.backgroundColor = .systemGray5
        warningDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        warningDescriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

enum Warnings {
    static let sessionNotReachable = "Session not reachable"
}
