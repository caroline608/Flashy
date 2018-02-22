//
//  TabBarController.swift
//  FlashCard
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public static func storyboardInstance() -> TabBarController {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        return tabBarController
    }
    
}
