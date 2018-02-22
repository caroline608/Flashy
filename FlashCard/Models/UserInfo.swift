////
////  UserInfo.swift
////  FlashCard
////
////  Created by C4Q on 2/19/18.
////  Copyright © 2018 C4Q. All rights reserved.
////
//
//import Foundation
////import FirebaseAuth
//
//struct UserInfo {
//        let userID: String
//        let username: String
//        let firstName: String
//        let lastName: String
//        let dateJoined: Date
//        
//        init(dict: [String : Any]) {
//            userID = dict["userID"] as? String ?? ""
//            username = dict["username"] as? String ?? ""
//            firstName = dict["firstName"] as? String ?? ""
//            lastName = dict["lastName"] as? String ?? ""
//            dateJoined = dict["dateJoined"] as? String ?? ""
//        }
//}

extension UserInfo {
    func parse(dict: [String : Any]) {
        userID = dict["userID"] as? String ?? ""
        username = dict["username"] as? String ?? ""
        firstName = dict["firstName"] as? String ?? ""
        lastName = dict["lastName"] as? String ?? ""
        //TODO parsing string to date
//        dateJoined = dict["dateJoined"]
    }
}

