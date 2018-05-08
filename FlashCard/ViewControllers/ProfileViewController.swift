//
//  ProfileViewController.swift
//  FlashCard
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController {

    var category: Category!
    let profileView = ProfileView()
    
    let authUserService = AuthUserService()
    
    private var userFlashCards = [FlashCard]() {
        didSet {
            profileView.profileFlashCardsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUserService.delegate = self
        profileView.profileFlashCardsCollectionView.delegate = self
        profileView.profileFlashCardsCollectionView.dataSource = self
        view.addSubview(profileView)
        setupNavBar()
        loadUserFlashCards()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        view.addSubview(profileView)
//        setupNavBar()
//        loadUserFlashCards()
//    }
//    
    private func setupNavBar() {
//        navigationItem.title = AuthUserService.getCurrentUser()!.displayName
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(signOut))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "\(AuthUserService.getCurrentUser()?.displayName ?? "FlashCards")"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sign out", style: .plain, target: self, action: #selector(signOut))
    }
    
    private func loadUserFlashCards() {
        DBService.manager.loadUserFlashCards { (dbUserFlashCards) in
            if let dbUserFlashCards = dbUserFlashCards {
                self.userFlashCards = dbUserFlashCards
            } else {
                print("Error retrieving user flash cards")
            }
        }
    }
    
    @objc private func signOut() {
        let alertView = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            self.authUserService.signOut()
        }
        let noOption = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ProfileViewController: AuthUserServiceDelegate {
    func didSignOut(_ authService: AuthUserService) {
         self.dismiss(animated: true, completion: nil)
        let loginController = LoginViewController.storyboardInstance()
        present(loginController, animated: true, completion: nil)
    }
    func didFailSigningOut(_ authService: AuthUserService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if userFlashCards.count > 0 {
            profileView.profileFlashCardsCollectionView.backgroundView = nil
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: profileView.profileFlashCardsCollectionView.bounds.size.width, height: profileView.profileFlashCardsCollectionView.bounds.size.height))
            noDataLabel.text = "You haven't created any FlashCards Yet"
            noDataLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            noDataLabel.textAlignment = .center
            profileView.profileFlashCardsCollectionView.backgroundView = noDataLabel
        }
        return numOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFlashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flashCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as! FlashCardCollectionViewCell
        let userFlashCard = userFlashCards[indexPath.row]
        flashCardCell.configureCell(flashCard: userFlashCard)
        return flashCardCell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let flashCardCell = collectionView.cellForItem(at: indexPath) as! FlashCardCollectionViewCell
        //UIView.transition(with: flashCardCell, duration: 0.3, options: .transitionFlipFromBottom, animations: nil, completion: nil)
    }
}
