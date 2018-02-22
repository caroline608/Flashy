//
//  LoginViewController.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    private var authUserService = AuthUserService()
    private var isNewUser = true
    
    private var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var loginMessageLabel: UILabel!

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var sumbitButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUserService.delegate = self
//        emailTextField.delegate = self
//        passwordTextfield.delegate = self
        loginMessageLabel.text = ""
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    public static func storyboardInstance() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return loginViewController
    }
    
    
    @IBAction func resetPasswordButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Reset Password", message: "Do you want to reset your password?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Reset", style: .destructive) { alert in
            self.authUserService.resetPassword(with: self.emailTextField.text!)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { alert in }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func toggleAuthentication(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        if buttonTitle == "Sign In" {
            signInButton.setTitle("Sign Up", for: .normal)
            sumbitButton.setTitle("Login", for: .normal)
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            isNewUser = false
        } else {
            signInButton.setTitle("Sign In", for: .normal)
            sumbitButton.setTitle("Create a New Account", for: .normal)
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            isNewUser = true
        }
    }
    
    @IBAction private func authActionButtonPressed() {
        view.endEditing(true)
        guard let emailText = emailTextField.text else { loginMessageLabel.text = "email is nil"; return }
        guard !emailText.isEmpty else { loginMessageLabel.text = "email is empty"; return }
        guard let passwordText = passwordTextfield.text else { loginMessageLabel.text = "password is nil"; return }
        guard !passwordText.isEmpty else { loginMessageLabel.text = "password is empty"; return }
        if isNewUser {
            let fName = firstNameTextField.text
            let lname = lastNameTextField.text
            authUserService.createUser(email: emailText, password: passwordText, firstName: fName ?? "", lastName: lname ?? "")
        } else {
            authUserService.signIn(email: emailText, password: passwordText)
        }
    }
       
    
    
    
//    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
//        let createAccountViewController = CreateAccountViewController()
//
//        createAccountViewController.modalTransitionStyle = .crossDissolve
//        createAccountViewController.modalPresentationStyle = .overCurrentContext
//        present(createAccountViewController, animated: true, completion: nil)
//    }
//
    
    private func clearSignUpFields() {
        emailTextField.text = ""
        passwordTextfield.text = ""
    }

}



extension LoginViewController: AuthUserServiceDelegate {
    
    func didCreateUser(_ userService: AuthUserService, user: User) {
        print("didCreateUser: \(user)")
        AuthUserService.getCurrentUser()!.sendEmailVerification(completion: {(error) in
            if let error = error {
                print("Error sending email verification, \(error)")
                self.loginMessageLabel.text = "Error sending email verification"
                self.authUserService.signOut()
            } else {
                print("E-mail verification sent")
                 self.loginMessageLabel.text = "E-mail verification sent"
                self.clearSignUpFields()
                self.authUserService.signOut()
            }
        })
        let tabController = TabBarController.storyboardInstance()
        present(tabController, animated: true, completion: nil)
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        loginMessageLabel.text = error.localizedDescription
    }
    
    func didSignIn(_ userService: AuthUserService, user: User) {
        if AuthUserService.getCurrentUser()!.isEmailVerified {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.loginMessageLabel.text = "Please verify e-mail"
            authUserService.signOut()
        }
        let tabController = TabBarController.storyboardInstance()
        present(tabController, animated: true, completion: nil)
    }
    
    func didFailToSignIn(_ userService: AuthUserService, error: Error) {
        loginMessageLabel.text = error.localizedDescription
    }
    
    func didSendResetPassword(_ authService: AuthUserService) {
        self.loginMessageLabel.text = "Password Reset e-mail sent, check spam inbox."
    }
    
    func didFailSendResetPassword(_ authService: AuthUserService, error: Error) {
        self.loginMessageLabel.text = "Error \(error.localizedDescription)"
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginMessageLabel.text = ""
    }
}
