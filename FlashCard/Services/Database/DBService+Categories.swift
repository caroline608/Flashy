//
//  DBService+Categories.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase
import CoreData

extension DBService {
    public func addCategory(name: String) {
        let childByAutoId = DBService.manager.getCategories().childByAutoId()
        let dateCreated = ISO8601DateFormatter().string(from: Date())
        childByAutoId.setValue(["categoryID"      : childByAutoId.key,
                                "userID"          : AuthUserService.getCurrentUser()!.uid,
                                "dateCreated"     : dateCreated,
                                "categoryName"    : name,
                                "numberOfCards" : 0]) { (error, dbRef) in
                                    if let error = error {
                                        print("addCategory error: \(error)")
                                    } else {
                                        print("category added @ database reference: \(dbRef)")
                                    }
        }
    }
    
    public func loadAllCategories(completionHandler: @escaping ([Category]?) -> Void) {
        let ref = DBService.manager.getCategories()
        ref.observe(.value) { (snapshot) in
            var allCategories = [Category]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    
                    //                CoreData Initializer
                    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
                    let entity = NSEntityDescription.entity(forEntityName: "Category", in: context!.viewContext)!
                    let category = NSManagedObject(entity: entity, insertInto: context!.viewContext) as! Category
                    category.parse(dict: dict)
                    
//                    let category = Category(dict: dict)
                    allCategories.append(category)
                }
            }
            completionHandler(allCategories)
        }
    }
    
    public func updateNumberOfFlashCards(in category: Category) {    DBService.manager.getCategories().child(category.categoryID!).updateChildValues(["numberOfCards":category.numberOfCards + 1])
    }
}
