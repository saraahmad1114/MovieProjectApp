//
//  Favorite+CoreDataProperties.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 11/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Favorite {

    @NSManaged var movies: Set<CoreMovies>?

}
