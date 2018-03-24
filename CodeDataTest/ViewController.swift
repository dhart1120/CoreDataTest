//
//  ViewController.swift
//  CodeDataTest
//
//  Created by Dustin Hart on 3/24/18.
//  Copyright © 2018 Dustin Hart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var repo = DataRepo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Creating Users");
        //_ = repo.createUser(username: "Bob", password: "Pa$$word", age: "23") // let bob = ...
        //_ = repo.createUser(username: "Ted", password: "pass1234", age: "25") // let ted = ...
        
        print("Printing Users")
        repo.printUsers()
        print()
        
        print("Searching for user")
        let result = repo.findUserBy(username: "Bob")
        if let user = result {
                print(user.username!)
        } else {
            print("Unable to find user")
        }
        print()
        
        print("Deleting user")
        repo.deleteUser(username: "Ted")
        print()
        
        print("Printing Users")
        repo.printUsers()
        print()
        
        repo.deleteAllUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

