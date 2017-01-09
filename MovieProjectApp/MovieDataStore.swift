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
    fileprivate init() {}
    
    var movies : [Movie] = []
    var pageNum = 1
    var favoriteMovies : [CoreMovie] = []
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.first.CoreDataToUSe" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
   
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
       // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
       // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
           try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
//            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreMovie")
        do {
            favoriteMovies = try self.managedObjectContext.fetch(fetchRequest) as! [CoreMovie]
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
       
    }
    
    //First API Call
    func getMoviesWithCompletion(_ pageNum: Int, query: String, Completion: @escaping (NSArray) -> ())
    {
        OMDBAPIClient.getMovieResultsFromSearch(query, page: self.pageNum) { (arrayOfMovies) in
            for singleMovie in arrayOfMovies
            {
                guard let unwrappedSingleMovie = singleMovie as? [String: Any]
                    else {print("singleMovie did not unwrap"); return}
                
                guard
                    let unwrappedMovieTitle = unwrappedSingleMovie["Title"] as? String,
                    let unwrappedMovieYear = unwrappedSingleMovie["Year"] as? String,
                    let unwrappedMovieImdbID = unwrappedSingleMovie["imdbID"] as? String,
                    let unwrappedMovieType = unwrappedSingleMovie["Type"] as? String,
                    let unwrappedMoviePosterURL = unwrappedSingleMovie["Poster"] as? String
                    
                else {print("ERROR OCCURRED HERE!"); return}
                
                let singleMovieObject = Movie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, imdbID: unwrappedMovieImdbID, type: unwrappedMovieType, posterURL: unwrappedMoviePosterURL)
            
                print("****************************************")
                print("Movie Title: \(singleMovieObject.title)")
                print("Movie Year: \(singleMovieObject.year)")
                print("Movie ImdbID: \(singleMovieObject.imdbID)")
                print("Movie Type: \(singleMovieObject.type)")
                print("Movie PosterURL: \(singleMovieObject.posterURL)")
                print("****************************************")
            
                self.movies.append(singleMovieObject)
                print(self.movies.count)
            }

            Completion(self.movies as NSArray)
        }
        
}
    //Second API Call
    func getDescriptiveMovieInformationWith(_ movie: Movie, Completion: @escaping (Bool) -> ())
    {
        guard let unwrappedimdbID = movie.imdbID else {print("AN ERROR OCCURRED HERE"); return}
        
        OMDBAPIClient.getDescriptiveMovieResultsFromSearch(unwrappedimdbID) { (descriptiveResponseDictionary) in
            
            guard let unwrappedDescriptiveResponseDictionary = descriptiveResponseDictionary as? [String: Any] else {print("descriptiveResponseDictionary did not unwrap"); return}
            
            guard let
                unwrappedDesMovieDirector = unwrappedDescriptiveResponseDictionary["Director"] as? String,
                let unwrappedDesMovieWriters = unwrappedDescriptiveResponseDictionary["Writer"] as? String,
                let unwrappedDesMovieActors = unwrappedDescriptiveResponseDictionary["Actors"] as? String,
                let unwrappedDesMovieShortPlot = unwrappedDescriptiveResponseDictionary["Plot"] as? String,
                let unwrappedDesMovieimbdRating = unwrappedDescriptiveResponseDictionary["imdbRating"] as? String
            
                else {print("DESCRIPTIVE RESPONSE DICTIONARY did not unwrap"); return}
            
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
    func getDescriptiveMovieFullPlotWith(_ movie: Movie, Completion: @escaping (Bool) -> ())
    {
        guard let unwrappedimdbID = movie.imdbID else {print("AN ERROR OCCURRED HERE"); return}
        
        OMDBAPIClient.getMovieFullPlotWith(unwrappedimdbID) { (fullPlotMovieDictionary) in
            
            guard let
            unwrappedFullPlot = fullPlotMovieDictionary["Plot"] as? String
            
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
