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
    
    //let store = MovieDataStore.sharedInstance
    
//NEEDED DESIGNATED INITIALIZER AND CONVENIENCE INITIALIZER!

// Insert code here to add functionality to your managed object subclass

//    convenience init(text: String, isCorrect: Bool, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
//        let entity = NSEntityDescription.entityForName("Alternative", inManagedObjectContext: context)!
//        self.init(entity: entity, insertIntoManagedObjectContext: context)
//        self.text = text
//        self.isCorrect = isCorrect
//    }
    
    //Designated Initializer
    
    init (context: NSManagedObjectContext,
         title: String,
         year: String,
         type: String,
         imdbID: String,
         posterURL: String) {
    }
    
    //Convenience Initializer 
    
    convenience init(entity: NSEntityDescription, context: NSManagedObjectContext, title: String, year: String, imdbID: String, type: String, posterURL : String) {

        self.init(entity: entity, context: context, title: title, year: year, imdbID: imdbID, type: type, posterURL: posterURL)
        
    }
    
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
    

    
//    convenience init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext, title: String, year: String, imdbID: String, type: String, posterURL: String) {
//        
//        super.init(entity: entity, insertIntoManagedObjectContext: context)
////        self.init(entity: entity, insertIntoManagedObjectContext: context)
//        self.title = title
//        self.year = year
//        self.imdbID = imdbID
//        self.type = type
//        self.posterURL = 
//    }
    
//    convenience init(name: String, text:String, context: NSManagedObjectContext){
//        
//        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: context);
//        self.init(entity: entity, insertIntoManagedObjectContext: context)
//        
//        self.text = text
//        self.name = name;
//    }
    
//    convenience init(title: String, year: String, imdbID: String, type: String, posterURL: String, context: NSManagedObjectContext)
//    {
//        let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)
//        self.title = title
//        self.year = year
//        self.imdbID = imdbID
//        self.type = type
//        self.posterURL = posterURL
//        
//    }
}
