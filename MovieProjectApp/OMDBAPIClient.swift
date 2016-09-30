//
//  OMDBAPIClient.swift
//  OperatingMovieAppProject
//
//  Created by Flatiron School on 9/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class OMDBAPIClient
{
    let store = MovieDataStore.sharedInstance
    
    //first API call to get information for the first View Controller
    class func getMovieResultsFromSearch(query: String, page: Int, completion:(NSArray)-> ()) {
        
        var dictionaryArray : [[String: String]] = []
        
        //&r=json&page=\(store.pageNum)
        
        var numResults: Int = 0
        
        var movieDatabaseURL = "https://www.omdbapi.com/?s=\(query)&r=json&page=\(page)"
        //take the regular database URL
        
//        if movieDatabaseURL.containsString(" ") {
        movieDatabaseURL = movieDatabaseURL.stringByReplacingOccurrencesOfString(" ", withString: "+")
//        }
        
        let nsurl = NSURL(string: movieDatabaseURL)
        //convert the url into an NSURL
        
        guard let unwrappedMovieDataBaseURL = nsurl else {print("AN ERROR OCCURRED HERE!"); return}
        //unwrapped the NSURL version of the URL
        
//        let session = NSURLSession.sharedSession()
        //creation of the session
        
        let request = NSMutableURLRequest(URL: unwrappedMovieDataBaseURL)
        //creation of the request
        
        request.HTTPMethod = "GET"
        //request has an HTTPMethod of type "GET" to obtain information
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                
                guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
                
                let totalResults = unwrappedResponseDictionary["totalResults"] as? String
                
                let searchArrayOfDictionaries = unwrappedResponseDictionary["Search"] as? NSArray
                
                guard let unwrappedSearchArrayOfDictionaries = searchArrayOfDictionaries else {print("Something went wrong"); return}
                
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
    
    //Second API call to get information for the Second View Controller
    class func getDescriptiveMovieResultsFromSearch(movieID: String, completion:(NSDictionary)-> ())
    {
        var descriptiveDictionary: [String: String] = [:]
        
        let searchURL = "https://www.omdbapi.com/?i=\(movieID)&?plot=short"
        
        let nsurl = NSURL(string: searchURL)
        //convert the url into an NSURL
        
        guard let unwrappedNSURL = nsurl else {print("ERROR OCCURRED HERE"); return}
        //unwrap the nsurl using guard let
        
        //let session = NSURLSession.sharedSession()
        //creation of the session 
        
        let request = NSMutableURLRequest(URL: unwrappedNSURL)
        //creation of the request
        
        request.HTTPMethod = "GET"
        //By Default everythiing is a GET request if you are getting information and you don't need it
        //request has an HTTPMethod of type "GET" to obtain information
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                let castedResponseDictionary = responseDictionary as? [String : String]
                
                guard let unwrappedResponseDictionary = castedResponseDictionary else {print("This did not work!"); return}
                
                descriptiveDictionary = unwrappedResponseDictionary
                
               //print(descriptiveDictionary)
               //information prints out fine! 
                
            }
            completion(descriptiveDictionary)
    }
        task.resume()
    }
    
    //third API Call to get information for the third View Controller to populate the full Plot of the movie 
    class func getMovieFullPlotWith(movieID: String, completion:(NSDictionary)-> ())
    {
        var movieDictionary: [String: String] = [:]
        
        let searchURLForFullPlot = "https://www.omdbapi.com/?i=\(movieID)&?plot=full"
        
        let nsURL = NSURL(string: searchURLForFullPlot)
        
        guard let unwrappedNSURL = nsURL else {print("AN ERROR OCCURRED HERE"); return}
        
        //let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: unwrappedNSURL)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                let castedResponseDictionary = responseDictionary as? [String : String]
                
                guard let unwrappedResponseDictionary = castedResponseDictionary else {print("This did not work!"); return}
                
                movieDictionary = unwrappedResponseDictionary
                
            }
            completion(movieDictionary)
        }
        
        task.resume()
}

}
