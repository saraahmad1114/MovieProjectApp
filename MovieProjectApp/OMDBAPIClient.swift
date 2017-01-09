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
    class func getMovieResultsFromSearch(_ query: String, page: Int, completion:@escaping (Array<Any>)-> ()) {
        
        var dictionaryArray : [[String: Any]] = []
                
        var movieDatabaseURL = "https://www.omdbapi.com/?s=\(query)&r=json&page=\(page)"
        
        movieDatabaseURL = movieDatabaseURL.replacingOccurrences(of: " ", with: "+")
        
        let nsurl = URL(string: movieDatabaseURL)
        
        guard let unwrappedMovieDataBaseURL = nsurl else {print("AN ERROR OCCURRED HERE!"); return}
        
        let request = URLRequest(url: unwrappedMovieDataBaseURL)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            let responseDictionary = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
        
                guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
                
                let searchArrayOfDictionaries = unwrappedResponseDictionary["Search"] as? Array<Any>
                
                guard let unwrappedSearchArrayOfDictionaries = searchArrayOfDictionaries else {print("Something went wrong"); return}
                
                for singleDictionary in unwrappedSearchArrayOfDictionaries
                {
                    let unwrappedSingleDictionary = singleDictionary as? [String:Any]
                    
                    guard let unwrappedAgainSingleDictionary = unwrappedSingleDictionary else {print("This works!"); return}
                    
                    dictionaryArray.append(unwrappedAgainSingleDictionary)
                }
                
                completion(dictionaryArray)
        }) 
        
        task.resume()
    }
    
    class func getDescriptiveMovieResultsFromSearch(_ movieID: String, completion:@escaping ([String: Any])-> ())
    {
        var descriptiveDictionary: [String: Any] = [:]
        
        let searchURL = "https://www.omdbapi.com/?i=\(movieID)&?plot=short"
        
        let url = URL(string: searchURL)
        
        guard let unwrappedURL = url else {print("URL DID NOT UNWRAP"); return}
            
        let request = URLRequest(url: unwrappedURL)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {print("JSON DATA DID NOT UPWRAP"); return}
            
             let responseDictionary = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
                
                guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
                
                descriptiveDictionary = unwrappedResponseDictionary
            
            completion(descriptiveDictionary)
        })
        
        task.resume()
    }
    
    
    
    class func getMovieFullPlotWith(_ movieID: String, completion:@escaping (NSDictionary)-> ())
    {
        var movieDictionary: [String: String] = [:]
        
        let searchURLForFullPlot = "https://www.omdbapi.com/?i=\(movieID)&?plot=full"
        
        let nsURL = URL(string: searchURLForFullPlot)
        
        guard let unwrappedNSURL = nsURL else {print("AN ERROR OCCURRED HERE"); return}
                
        let request = URLRequest(url: unwrappedNSURL)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
             let responseDictionary = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! NSDictionary
            
                let castedResponseDictionary = responseDictionary as? [String : String]
                
                guard let unwrappedResponseDictionary = castedResponseDictionary else {print("This did not work!"); return}
                
                movieDictionary = unwrappedResponseDictionary
            
            completion(movieDictionary as NSDictionary)
        }) 
        
        task.resume()
    }

}
