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
    
    convenience init(entity: NSEntityDescription, context: NSManagedObjectContext) {

        self.init(entity: entity, context: context)
    }
}
