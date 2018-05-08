////
////  Category.swift
////  FlashCard
////
////  Created by C4Q on 2/19/18.
////  Copyright © 2018 C4Q. All rights reserved.
////
//
//import Foundation
//
//class Category {
//    let userID: String
//    let categoryName: String
//    let categoryID: String
//    let numberOfCards: Int
//    let dateCreated: String
//    
//    init(dict: [String : Any]) {
//        userID = dict["userID"] as? String ?? ""
//        categoryName = dict["categoryName"] as? String ?? ""
//        categoryID = dict["categoryID"] as? String ?? ""
//        numberOfCards = dict["numberOfCards"] as? Int ?? 0
//        dateCreated = dict["dateCreated"] as? String ?? ""
//    }
//}

extension Category{
    func parse(dict: [String : Any]) {
        userID = dict["userID"] as? String
        categoryName = dict["categoryName"] as? String
        categoryID = dict["categoryID"] as? String
        numberOfCards = dict["numberOfCards"] as? Int16 ?? 0
        //TODO: string to date
//        dateCreated = dict["dateCreated"] as? String ?? ""
    }
}

