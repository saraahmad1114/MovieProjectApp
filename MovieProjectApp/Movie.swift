//
//  Movie.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData


class Movie: NSManagedObject {
    
        convenience init(title: String, year: String, type: String, imdbID: String, posterURL: String, entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext)
        {
            self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
            self.title = title
            self.year = year
            self.type = type
            self.imdbID = imdbID
            self.posterURL = posterURL
        }

}
