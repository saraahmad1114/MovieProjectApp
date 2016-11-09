//
//  Movie+CoreDataProperties.swift
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

extension Movie {

    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var imdbRating: String?
    @NSManaged var newRelationship: NSManagedObject?

}
