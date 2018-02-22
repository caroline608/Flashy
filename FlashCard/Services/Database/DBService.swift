//
//  DBService.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    private init(){
        // reference to the root of the Firebase database
        dbRef = Database.database().reference()
        
        // children of root database node
        usersRef = dbRef.child("users")
        categoriesRef = dbRef.child("categories")
        flashCardsRef = dbRef.child("flashCards")
        
    }
    static let manager = DBService()
    
    
    private var dbRef: DatabaseReference!
    private var usersRef: DatabaseReference!
    private var categoriesRef: DatabaseReference!
    private var flashCardsRef: DatabaseReference!
    
    
    public func formatDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY h:mm a"
        return dateFormatter.string(from: date)
    }
    
    public func getDB()-> DatabaseReference { return dbRef }
    public func getUsers()-> DatabaseReference { return usersRef }
    public func getCategories()-> DatabaseReference { return categoriesRef }
    public func getFlashCards()-> DatabaseReference { return flashCardsRef }
}
