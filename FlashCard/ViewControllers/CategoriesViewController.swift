//
//  CategoriesViewController.swift
//  FlashCard
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    private var authUserService = AuthUserService()
    
    let categoriesView = CatagoriesView()
    
    var categories = [Category]() {
        didSet{
            categoriesView.categoriesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(categoriesView)
        categoriesView.categoriesTableView.delegate = self
        categoriesView.categoriesTableView.dataSource = self
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        if AuthUserService.getCurrentUser() == nil {
            let loginVC = LoginViewController()
            self.present(loginVC, animated: false, completion: nil)
        } else {
            loadCategories()
        }
    }
    
    private func loadCategories() {
        DBService.manager.loadAllCategories(completionHandler: { (categories) in
            if let categories = categories { self.categories = categories }
            else { print("error loading categories") }
        })
    }
    
    @objc private func addCategory() {
        let alertController = UIAlertController(title: "New Category", message: "Enter new category", preferredStyle: .alert)
        alertController.addTextField()
        let addAction = UIAlertAction(title: "Add", style: .default) {alert in
            let userTexInput = alertController.textFields![0].text!
            guard !userTexInput.isEmpty else {
                self.showAlert(title: "Error", message: "Must enter a new category name")
                return
            }
            DBService.manager.addCategory(name: userTexInput)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {alert in
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    public static func storyboardInstance() -> CategoriesViewController {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
        return tabBarController
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if categories.count > 0 {
            categoriesView.categoriesTableView.backgroundView = nil
            categoriesView.categoriesTableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: categoriesView.categoriesTableView.bounds.size.width, height: categoriesView.categoriesTableView.bounds.size.height))
            noDataLabel.text = "No categories yet!"
            noDataLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            noDataLabel.textAlignment = .center
            categoriesView.categoriesTableView.backgroundView = noDataLabel
            categoriesView.categoriesTableView.separatorStyle = .none
        }
        return numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        categoryCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "categoryCell")
        let category = categories[indexPath.row]
        categoryCell.textLabel?.text = category.categoryName
        categoryCell.detailTextLabel?.text = category.numberOfCards.description
        return categoryCell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        let flashCardsVC = FlashCardViewController(category: selectedCategory)
        self.navigationController?.pushViewController(flashCardsVC, animated: true)
    }
}
