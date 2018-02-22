//
//  CreateFlashCardViewController.swift
//  FlashCard
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

protocol CreateFlashCardViewControllerDelegate: class {
    func didAddNewFlashCard(_ createFlashCardViewController: CreateFlashCardViewController)
}

class CreateFlashCardViewController: UIViewController {

        
        private let createFlashCardView = CreateFlashCardView()
        
        private var category: Category!
        
        public weak var delegate: CreateFlashCardViewControllerDelegate?
        
        init(category: Category) {
            super.init(nibName: nil, bundle: nil)
            self.category = category
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(createFlashCardView)
            setupNavBar()
        }
        
        private func setupNavBar() {
            navigationItem.title = "New Flash Card"
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createFlashCard))
        }
        
        @objc private func cancel() {
            self.dismiss(animated: true, completion: nil)
        }
        
        @objc private func createFlashCard() {
            
            let question = createFlashCardView.questionTextView.text
            let answer = createFlashCardView.answerTextView.text
            DBService.manager.addFlashCard(question: question!, answer: answer!, categoryID: category.categoryID!, categoryName: category.categoryName!)
            
            dismiss(animated: true) {
                self.delegate?.didAddNewFlashCard(self)
            }
        }
        
        private func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
}

