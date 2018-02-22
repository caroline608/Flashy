//
//  CreateAccountView.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CreateAccountView: UIView {

    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"dismissButtonIcon"), for: .normal)
        return button
    }()
    
    
    
//    lazy var profileImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
    
    lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "User name"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var displayNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter user name"
//        textField.text =
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "E-mail"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        label.text = "Password"
        label.textColor = .black
        return label
    }()
    
    lazy var verifyPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        label.text = "Verify password"
        label.textColor = .black
        return label
    }()
    
    lazy var emailLoginTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter email address"
        textField.text = "carolinecruz@ac.c4q.nyc"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter password"
        textField.text = "testing"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var verifyPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Verify password"
        textField.text = "testing"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        
        // make profile image a circle
//        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
//        profileImage.layer.masksToBounds = true
    }
    
    private func setupViews() {
        setupBlurEffectView()
        setupDismissView()
        setupContainerView()
        setupDismissButton()
        setupEmailLoginTextField()
        setupEmailAddressLabel()
        setupPasswordTextField()
        setupPasswordLabel()
        setupVerifyPasswordTextField()
        setupVerifyPasswordLabel()
        setupSignUpButton()
        setupDisplayNameTextField()
        setupDisplayNameLabel()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupDismissView() {
        addSubview(dismissView)
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80).isActive = true
    }
    
    private func setupDismissButton()  {
        addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupEmailLoginTextField() {
        addSubview(emailLoginTextField)
        emailLoginTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setupEmailAddressLabel() {
        addSubview(emailAddressLabel)
        emailAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailLoginTextField.snp.bottom).offset(2)
            make.leading.equalTo(emailLoginTextField.snp.leading).offset(8)
        }
    }
    
    
    private func setupDisplayNameTextField() {
        addSubview(displayNameTextField)
        displayNameTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(emailLoginTextField.snp.top).offset(-24)
            make.leading.equalTo(emailLoginTextField.snp.leading)
            make.width.equalTo(emailLoginTextField.snp.width).multipliedBy(0.48)
        }
    }
    
    private func setupDisplayNameLabel() {
        addSubview(displayNameLabel)
        displayNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(displayNameTextField.snp.bottom).offset(2)
            make.leading.equalTo(displayNameTextField.snp.leading).offset(8)
        }
    }
    

    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailAddressLabel.snp.bottom).offset(8)
            make.leading.equalTo(emailLoginTextField.snp.leading)
            make.width.equalTo(emailLoginTextField.snp.width)
        }
    }
    
    private func setupPasswordLabel() {
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
            make.leading.equalTo(passwordTextField.snp.leading).offset(8)
        }
    }
    
    private func setupVerifyPasswordTextField() {
        addSubview(verifyPasswordTextField)
        verifyPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.width.equalTo(passwordTextField.snp.width)
        }
    }
    
    private func setupVerifyPasswordLabel() {
        addSubview(verifyPasswordLabel)
        verifyPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(verifyPasswordTextField.snp.bottom).offset(2)
            make.leading.equalTo(verifyPasswordTextField.snp.leading).offset(8)
        }
    }
    
    private func setupSignUpButton() {
        addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(verifyPasswordLabel.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        }
    }

}
