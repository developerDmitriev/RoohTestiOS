//
//  CreateProfileViewController.swift
//  RoohiOS
//
//  Created by Cezar_ on 08.02.24.
//

import UIKit

class CreateProfileViewController: UIViewController {
    var presenter: CreateProfilePresenter?
    
    lazy private var weightPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private var profileName: String = Costnats.profileName {
        didSet {
            nameDidUpdate()
        }
    }
    private var profileAge: Int = 0 {
        didSet {
            ageDidUpdate()
        }
    }
    var profileHeight: Int = 0 {
        didSet {
            heightDidUpdate()
        }
    }
    var profileWeight: Double = 0 {
        didSet {
            weightDidUpdate()
        }
    }
    
    lazy private var continueButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = Costnats.continueButtonTitle
        let button = UIButton(configuration: configuration)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = profileName
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        return nameLabel
    }()
    
    lazy private var ageField: UITextField = {
        let ageField = UITextField()
        ageField.placeholder = Costnats.profileAge + String(profileAge)
        ageField.font = .systemFont(ofSize: 17, weight: .heavy)
        ageField.borderStyle = .none
        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.delegate = self
        ageField.keyboardType = .numberPad
        return ageField
    }()
    
    lazy private var heightField: UITextField = {
        let heightField = UITextField()
        heightField.placeholder = Costnats.profileHeight + String(profileHeight)
        heightField.font = .systemFont(ofSize: 17, weight: .heavy)
        heightField.borderStyle = .none
        heightField.translatesAutoresizingMaskIntoConstraints = false
        heightField.keyboardType = .numberPad
        heightField.delegate = self
        return heightField
    }()
    
    lazy private var weightField: UITextField = {
        let weightField = UITextField()
        weightField.placeholder = Costnats.profileWeight + String(profileWeight)
        weightField.font = .systemFont(ofSize: 17, weight: .heavy)
        weightField.borderStyle = .none
        weightField.translatesAutoresizingMaskIntoConstraints = false
        weightField.inputView = weightPicker
        return weightField
    }()
    
    private var avatarsCollectionView = AvatarCollectionView()
    private var avatars = [ProfileAvatar]() {
        didSet {
            avatarsCollectionView.setupAvatars(with: avatars)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupUI()
        
        presenter?.fetchAvatars()
        avatarsCollectionView.mainView = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)

    }
    
    private func setupUI() {
        view.addSubview(avatarsCollectionView)
        view.addSubview(nameLabel)
        view.addSubview(ageField)
        view.addSubview(heightField)
        view.addSubview(weightField)
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(continueButtonDidTap), for: .touchUpInside)
        
        avatarsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        avatarsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        avatarsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        avatarsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        avatarsCollectionView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: avatarsCollectionView.bottomAnchor, constant: 32).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        ageField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        ageField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        heightField.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 16).isActive = true
        heightField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        weightField.topAnchor.constraint(equalTo: heightField.bottomAnchor, constant: 16).isActive = true
        weightField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
    }
    
    func updateAvatars(with avatars: [ProfileAvatar]) {
        self.avatars = avatars
    }
    
    func updateNameLabel(with name: String) {
        self.profileName = name
    }
    
    func updateButtonState(isActive: Bool) {
        continueButton.isEnabled = isActive
    }
    
    //TODO: call here presenter filling model methods
    private func nameDidUpdate() {
        nameLabel.text = "\(Costnats.profileName) \(profileName)"
        presenter?.updateProfileModel(avatar: avatars[avatarsCollectionView.currentIndex])
    }
    
    private func ageDidUpdate() {
        ageField.text = "\(Costnats.profileAge) \(profileAge)"
        presenter?.updateProfileModel(age: profileAge)
    }
    
    private func heightDidUpdate() {
        heightField.text = "\(Costnats.profileHeight) \(profileHeight)"
        presenter?.updateProfileModel(height: profileHeight)
    }
    
    private func weightDidUpdate() {
        weightField.text = "\(Costnats.profileWeight) \(profileWeight)"
        presenter?.updateProfileModel(weight: profileWeight)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        
        if !weightPicker.frame.contains(touchPoint) && !weightField.frame.contains(touchPoint) {
            //weightPicker.isHidden = true
            view.endEditing(true)
        }
    }
    @objc private func continueButtonDidTap(_ sender: UIButton) {
        presenter?.sendDataToWatch()
    }
}

extension CreateProfileViewController {
    enum Costnats {
        static let profileName = "My name is "
        static let profileAge = "My age is "
        static let profileHeight = "My height is "
        static let profileWeight = "My weight is "
        static let continueButtonTitle = "Continue"
    }
}

extension CreateProfileViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 200
    }
}

extension CreateProfileViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row) kg"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        profileWeight = Double(row)
    }
}

extension CreateProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case ageField:
            profileAge = Int(text) ?? 0
        case heightField:
            profileHeight = Int(text) ?? 0
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
