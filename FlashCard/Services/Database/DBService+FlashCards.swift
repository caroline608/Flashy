//
//  DBService+FlashCards.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase
import CoreData

extension DBService {
    public func addFlashCard(question: String, answer: String, categoryID: String, categoryName: String) {
        let childByAutoId = DBService.manager.getFlashCards().childByAutoId()
        let dateCreated = ISO8601DateFormatter().string(from: Date())
        childByAutoId.setValue(["flashCardID" : childByAutoId.key,
                                "userID"      : AuthUserService.getCurrentUser()!.uid,
                                "username"    : AuthUserService.getCurrentUser()!.displayName,
                                "question"    : question,
                                "answer"      : answer,
                                "categoryID"  : categoryID,
                                "categoryName": categoryName,
                                "dateCreated" : dateCreated]) { (error, dbRef) in
                                    if let error = error {
                                        print("addFlashCard error: \(error)")
                                    } else {
                                        print("flashCard added @ database reference: \(dbRef)")
                                    }
        }
    }
    
    public func loadAllFlashCards(with category: Category, completionHandler: @escaping ([FlashCard]?) -> Void) {
        let ref = DBService.manager.getFlashCards()
        ref.observe(.value) { (snapshot) in
            var flashCards = [FlashCard]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    //                CoreData Initializer
                    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
                    let entity = NSEntityDescription.entity(forEntityName: "FlashCard", in: context!.viewContext)!
                    let flashcard = NSManagedObject(entity: entity, insertInto: context!.viewContext) as! FlashCard
                    flashcard.parse(dict: dict)
//                    let flashCard = FlashCard()
//                    flashCard.parse(dict: dict)
                    if flashcard.categoryID == category.categoryID {
                        flashCards.append(flashcard)
                    }
                }
            }
            completionHandler(flashCards)
        }
    }
    
    public func loadUserFlashCards(completionHandler: @escaping ([FlashCard]?) -> Void) {
        let ref = DBService.manager.getFlashCards()
        ref.observe(.value) { (snapshot) in
            var flashCards = [FlashCard]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    
                    //                CoreData Initializer
                    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
                    let entity = NSEntityDescription.entity(forEntityName: "FlashCard", in: context!.viewContext)!
                    let flashcard = NSManagedObject(entity: entity, insertInto: context!.viewContext) as! FlashCard
                    flashcard.parse(dict: dict)
//                    let flashCard = FlashCard()
//                    flashCard.parse(dict: dict)
                    if flashcard.userID == AuthUserService.getCurrentUser()!.uid {
                        flashCards.append(flashcard)
                    }
                }
            }
            completionHandler(flashCards)
        }
    }
}
