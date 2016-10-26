//
//  MovieDataStore.swift
//  OperatingMovieAppProject
//
//  Created by Flatiron School on 9/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class MovieDataStore
{
    
    static let sharedInstance = MovieDataStore()
    private init() {}
    
    var movies : [Movie] = []
    var favoriteMovies : [Favorites] = []

    
    var pageNum = 1
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.first.CoreDataToUSe" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("MovieProjectApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func fetchData ()
    {
        let fetchRequest = NSFetchRequest(entityName: "Favorites")
        do {
            favoriteMovies = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Favorites]
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
    }
    
    //First API Call
    func getMoviesWithCompletion(pageNum: Int, query: String, Completion: (NSArray) -> ())
    {
        OMDBAPIClient.getMovieResultsFromSearch(query, page: self.pageNum) { (arrayOfMovies) in
            for singleMovie in arrayOfMovies
            {
                let movieTitle = singleMovie["Title"] as? String
                let movieYear = singleMovie["Year"] as? String
                let movieImbdID = singleMovie["imdbID"] as? String
                let movieType = singleMovie["Type"] as? String
                let moviePosterURL = singleMovie["Poster"] as? String
                
                guard let
                    unwrappedMovieTitle = movieTitle,
                    unwrappedMovieYear = movieYear,
                    unwrappedMovieImbdID = movieImbdID,
                    unwrappedMovieType = movieType,
                    unwrappedMoviePosterURL = moviePosterURL
                
                    else {print("ERROR OCCURRED HERE!"); return}
                
                let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: self.managedObjectContext)
                
                guard let unwrappedEntity = entity else {print("AN ERROR OCCURRED HERE"); return}
                
                let singleMovieObject = Movie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, type: unwrappedMovieType, imdbID: unwrappedMovieImbdID, posterURL: unwrappedMoviePosterURL, entity: unwrappedEntity, managedObjectContext: self.managedObjectContext)
            /*
                print("****************************************")
                print("Movie Title: \(singleMovieObject.title)")
                print("Movie Year: \(singleMovieObject.year)")
                print("Movie ImdbID: \(singleMovieObject.imdbID)")
                print("Movie Type: \(singleMovieObject.type)")
                print("Movie PosterURL: \(singleMovieObject.posterURL)")
                print("****************************************")
            */
                self.movies.append(singleMovieObject)
                print(self.movies.count)
            }

            Completion(self.movies)
        }
        
}
    //Second API Call
    func getDescriptiveMovieInformationWith(movie: Movie, Completion: (Bool) -> ())
    {
        guard let unwrappedimdbID = movie.imdbID else {print("AN ERROR OCCURRED HERE"); return}
        OMDBAPIClient.getDescriptiveMovieResultsFromSearch(unwrappedimdbID) { (descriptiveResponseDictionary) in
            
            let desMovieDirector = descriptiveResponseDictionary["Director"] as? String
            let desMovieWriters = descriptiveResponseDictionary["Writer"] as? String
            let desMovieActors = descriptiveResponseDictionary["Actors"] as? String
            let desMovieShortPlot = descriptiveResponseDictionary["Plot"] as? String
            let desMovieimbdRating = descriptiveResponseDictionary["imdbRating"] as? String
            
            guard let
                unwrappedDesMovieDirector = desMovieDirector,
                unwrappedDesMovieWriters = desMovieWriters,
                unwrappedDesMovieActors = desMovieActors,
                unwrappedDesMovieShortPlot = desMovieShortPlot,
                unwrappedDesMovieimbdRating = desMovieimbdRating
            
                else {print("AN ERROR OCCURRED HERE!"); return}
            
                movie.director = unwrappedDesMovieDirector
                movie.writers = unwrappedDesMovieWriters
                movie.actors = unwrappedDesMovieActors
                movie.shortPlot = unwrappedDesMovieShortPlot
                movie.imdbRating = unwrappedDesMovieimbdRating
            
                print("******************************************")
                print("Movie Director: \(movie.director)")
                print("Movie writers: \(movie.writers)")
                print("Movie actors: \(movie.actors)")
                print("Movie shortPlot: \(movie.shortPlot)")
                print("Movie imdbRating: \(movie.imdbRating)")
                print("******************************************")
 
            Completion(true)
        }
        
    }
    
    //Third API Call
    func getDescriptiveMovieFullPlotWith(movie: Movie, Completion: (Bool) -> ())
    {
        guard let unwrappedimdbID = movie.imdbID else {print("AN ERROR OCCURRED HERE"); return}
        
        OMDBAPIClient.getMovieFullPlotWith(unwrappedimdbID) { (fullPlotMovieDictionary) in
            
            let movieFullPlot = fullPlotMovieDictionary["Plot"] as? String
            
            guard let
            unwrappedFullPlot = movieFullPlot
            
            else {print("AN ERROR OCCURRED HERE"); return}
            
            movie.fullPlot = unwrappedFullPlot
            
            print("******************************************")
            print("Movie FullPlot: \(movie.fullPlot)")
            print("******************************************")
            Completion(true)
        }
    }

    //pagination Function
    func retrieveNextPageOfMovieInformation()
    {
        self.pageNum += 1
    }
    
    


    
}