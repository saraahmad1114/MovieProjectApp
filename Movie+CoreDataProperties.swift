//
//  Movie+CoreDataProperties.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var actors: String?
    @NSManaged var director: String?
    @NSManaged var fullPlot: String?
    @NSManaged var imdbID: String?
    @NSManaged var imdbRating: String?
    @NSManaged var posterURL: String?
    @NSManaged var shortPlot: String?
    @NSManaged var title: String?
    @NSManaged var writers: String?
    @NSManaged var year: String?
    @NSManaged var type: String?

}
