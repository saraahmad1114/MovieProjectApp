//
//  OMDBAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

//let store = MovieDataStore.sharedInstance

class OMDBAPIClient
{
    class func getMovieResultsFromSearch(query: String, completion:(NSArray)-> ()) {
        
    var dictionaryArray : [[String: String]] = []
    
    var numResults: Int = 0
    
    let movieDatabaseURL = "http://www.omdbapi.com/?s=\(query)"
    //take the regular database URL
        
    let nsurl = NSURL(string: movieDatabaseURL)
    //convert the url into an NSURL 
        
    guard let unwrappedMovieDataBaseURL = nsurl else {print("This is wrong"); return}
    //unwrapped the NSURL version of the URL
        
    let session = NSURLSession.sharedSession()
    //creation of the session
        
    let request = NSMutableURLRequest(URL: unwrappedMovieDataBaseURL)
    //creation of the request
        
    request.HTTPMethod = "GET"
    //request has an HTTPMethod of type "GET" to obtain information
        
    let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
    guard let unwrappedData = data else {print("Error occurred here"); return}
        
    if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
        {
            
        guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
            
            let totalResults = unwrappedResponseDictionary["totalResults"] as? String
            
            guard let unwrappedTotalResults = totalResults else{print("No total results given"); return}
            
            numResults = Int(unwrappedTotalResults)!
            
            let searchArrayOfDictionaries = unwrappedResponseDictionary["Search"] as? NSArray

            guard let unwrappedSearchArrayOfDictionaries = searchArrayOfDictionaries else {print("Something went wrong"); return}
            
            //print(unwrappedSearchArrayOfDictionaries)
            
            for singleDictionary in unwrappedSearchArrayOfDictionaries
            {
                let unwrappedSingleDictionary = singleDictionary as? [String: String]
                
                guard let unwrappedAgainSingleDictionary = unwrappedSingleDictionary else {print("This works!"); return}
                
                dictionaryArray.append(unwrappedAgainSingleDictionary)
            }
        
            completion(dictionaryArray)
        }
        
    }
        
    task.resume()
        
    }
    
}
