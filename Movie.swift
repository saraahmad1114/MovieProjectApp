//
//  Movie.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData


class Movie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

//    convenience init(text: String, isCorrect: Bool, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
//        let entity = NSEntityDescription.entityForName("Alternative", inManagedObjectContext: context)!
//        self.init(entity: entity, insertIntoManagedObjectContext: context)
//        self.text = text
//        self.isCorrect = isCorrect
//    }
    
//    convenience init(entity: NSEntityDescription, context: NSManagedObjectContext) {
//
//        self.init(entity: entity, context: context)
//    }
    
//    convenience init(title: String, year: String, imdbID: String, type: String, posterURL: String, managedObjectContext: NSManagedObjectContext) {
//        
//        self.init(managedObjectContext: managedObjectContext)
//        
//        self.title = title
//        self.year = year
//        self.imdbID = imdbID
//        self.type = type
//        self.posterURL = posterURL
//    }
    
    convenience init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?, title: String, year: String, imdbID: String, type: String, posterURL: String) {
        
        self.init(entity: entity, insertIntoManagedObjectContext: context, title: title, year: year, imdbID: imdbID, type: type, posterURL: posterURL)
        
    }
}
