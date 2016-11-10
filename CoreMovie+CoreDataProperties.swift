//
//  CoreMovie+CoreDataProperties.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 11/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CoreMovie {

    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var imdbRating: String?
    @NSManaged var posterURL: String?
    @NSManaged var newRelationship: Favorite?

}
