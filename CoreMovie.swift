//
//  CoreMovie.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 11/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData


class CoreMovie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    convenience init(title: String, year: String, imdbRating: String, entity: NSEntityDescription, posterURL: String, managedObjectContext: NSManagedObjectContext)
    {
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
        self.title = title
        self.year = year
        self.imdbRating = imdbRating
        self.posterURL = posterURL
        
    }

}
