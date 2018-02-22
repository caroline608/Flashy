////
////  FlashCard.swift
////  FlashCard
////
////  Created by C4Q on 2/19/18.
////  Copyright © 2018 C4Q. All rights reserved.
////
//
//import Foundation
//
//class FlashCard {
//    let flashCardID: String
//    let userID: String
//    let username: String
//    let question: String
//    let answer: String
//    let categoryID: String
//    let categoryName: String
//    let dateCreated: Date
//    
//    init(dict: [String : Any]) {
//        flashCardID = dict["flashCardID"] as? String ?? ""
//        userID = dict["userID"] as? String ?? ""
//        username = dict["username"] as? String ?? ""
//        question = dict["question"] as? String ?? ""
//        answer = dict["answer"] as? String ?? ""
//        categoryID = dict["categoryID"] as? String ?? ""
//        categoryName = dict["categoryName"] as? String ?? ""
//        dateCreated = dict["dateCreated"] as? Date ?? ""
//    }
//}

extension FlashCard {
    func parse(dict: [String : Any]) {
        flashCardID = dict["flashCardID"] as? String ?? ""
        userID = dict["userID"] as? String ?? ""
        username = dict["username"] as? String ?? ""
        question = dict["question"] as? String ?? ""
        answer = dict["answer"] as? String ?? ""
        categoryID = dict["categoryID"] as? String ?? ""
        categoryName = dict["categoryName"] as? String ?? ""
        //TODO: String to date
//        dateCreated = dict["dateCreated"] as? Date ?? ""
    }
}
