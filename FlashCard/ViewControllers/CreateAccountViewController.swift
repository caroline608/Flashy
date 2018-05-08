//
//  CreateAccountViewController.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    let createAccountView = CreateAccountView()
    private var tapGesture: UITapGestureRecognizer!
    
//    this override is for injection, I want this view to pop up in the viewcontroller
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(createAccountView)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // setup dismiss buttons
        createAccountView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        createAccountView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    
}



