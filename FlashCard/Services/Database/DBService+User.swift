//
//  DBService+User.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

extension DBService {
    
    public func addUser(firstName: String, lastName: String) {
        let user = DBService.manager.getUsers().child(AuthUserService.getCurrentUser()!.uid)
        user.setValue(["userID"     : AuthUserService.getCurrentUser()!.uid,
                       "username"   : AuthUserService.getCurrentUser()!.displayName!,
                       "firstName"  : firstName,
                       "lastName"   : lastName,
                       "dateJoined" : formatDate(with: Date())]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("user added @ database reference: \(dbRef)")
                        }
        }
    }
}
