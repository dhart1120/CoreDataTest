//
//  DataRepo.swift
//  CodeDataTest
//
//  Created by Dustin Hart on 3/24/18.
//  Copyright © 2018 Dustin Hart. All rights reserved.
//

import Foundation
import CoreData

class DataRepo {
    
    // loading container for entities. "models" references the "models.xcdatamodeld" file
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "models")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    func createUser(username: String, password: String, age: String) -> User {
        let managedContext = persistentContainer.viewContext
        
        // Create a new user entity within the context
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        // set values on that user
        user.setValue(username, forKey: "username")
        user.setValue(password, forKey: "password")
        user.setValue(age, forKey: "age")
        
        // save the changes made to the context
        do {
            try managedContext.save()
        } catch {
            print("createUser: failed to create user")
        }
        
        return user as! User;
    }
    
    func findUserBy(username: String) -> User? {
        let managedContext = persistentContainer.viewContext
        
        // create a query to get User entities by username
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "username = %@", username)
        request.returnsObjectsAsFaults = false
        do {
            // get results and then pull the first (optional)
            let users = try managedContext.fetch(request)
            return (users as! [User]).first
        } catch {
            print("findUserBy: Failed to find user with username: \(username)")
        }
        return nil;
    }
    
    func deleteUser(username: String) {
        let managedContext = persistentContainer.viewContext
        
        let user = findUserBy(username: username)
        if user != nil {
            managedContext.delete(user!)
            
            do {
                try managedContext.save()
            } catch {
                print("deleteUser: failed to delete user")
            }
        }
        // Does nothing if user not found
    }
    
    func printUsers() {
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let users = try managedContext.fetch(request)
            for user in users as! [User] {
                print("\(user.username!) \(user.password!) \(user.age!)")
            }
        } catch {
            print("printUsers: failed to print users")
        }
    }
    
    func deleteAllUsers() {
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let users = try managedContext.fetch(request)
            for user in users as! [User] {
                managedContext.delete(user)
            }
            
            do {
                try managedContext.save()
            } catch {
                print("deleteAllUsers: failed to delete user(s)")
            }
        } catch {
            print("printUsers: failed to print users")
        }

    }
}
