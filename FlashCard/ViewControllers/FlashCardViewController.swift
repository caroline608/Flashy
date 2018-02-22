//
//  FlashCardViewController.swift
//  FlashCard
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {

    private let flashCardsView = FlashCardsView()
    
    private var category: Category!
    
    private var flashCards = [FlashCard]() {
        didSet {
            flashCardsView.flashCardsCollectionView.reloadData()
        }
    }
    
    init(category: Category) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashCardsView.flashCardsCollectionView.delegate = self
        flashCardsView.flashCardsCollectionView.dataSource = self
        view.addSubview(flashCardsView)
        setupNavBar()
        loadFlashCards()
    
    }
    
    private func setupNavBar() {
        navigationItem.title = category.categoryName
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFlashCard))
    }
    
    private func loadFlashCards() {
        DBService.manager.loadAllFlashCards(with: category) { (dbFlashCards) in
            if let dbFlashCards = dbFlashCards {
                self.flashCards = dbFlashCards
            } else {
                print("Error retrieving flashCards")
            }
        }
    }
    
    @objc private func addNewFlashCard() {
        let createFCVC = CreateFlashCardViewController(category: category)
        createFCVC.delegate = self
        let createFCVCNavCon = UINavigationController(rootViewController: createFCVC)
        createFCVCNavCon.modalTransitionStyle = .coverVertical
        createFCVCNavCon.modalPresentationStyle = .overFullScreen
        present(createFCVCNavCon,animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FlashCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flashCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as! FlashCardCollectionViewCell
        let flashCard = flashCards[indexPath.row]
        flashCardCell.configureCell(flashCard: flashCard)
        return flashCardCell
    }
}

extension FlashCardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension FlashCardViewController: CreateFlashCardViewControllerDelegate {
    func didAddNewFlashCard(_ newFlashCardViewController: CreateFlashCardViewController) {
        DBService.manager.updateNumberOfFlashCards(in: category)
        showAlert(title: "Success", message: "Added new FlashCard")
    }
}

