//
//  iTunesAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 11/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class iTunesAPIClient{

    class func getMovieSoundTrackFromSearch(_ query: String, completion:@escaping (NSArray)-> ())
    {
        var resultsArrayOfDictionary : [NSDictionary] = []
        
        var itunesURL = "https://itunes.apple.com/search?term=\(query)+soundtrack&limit=30"
        
        itunesURL = itunesURL.replacingOccurrences(of: " ", with: "+")
        
        let nsURL = URL(string: itunesURL)
        
        guard let unwrappednsURL = nsURL else {print("url error"); return}
        
        let request = URLRequest(url: unwrappednsURL)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            let responseDictionary = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! NSDictionary
            
                guard let unwrappedResponseDictionary = responseDictionary else {print("nothing in response dictionary"); return}
                
                let resultsArrayOfDictionaries = unwrappedResponseDictionary["results"] as? NSArray
                
                guard let unwrappedResultsArrayOfDictionaries = resultsArrayOfDictionaries else {
                    print("ERROR"); return}
                
                for singleDictionary in unwrappedResultsArrayOfDictionaries
                {
                    let castedSingleDictionary = singleDictionary as? NSDictionary
                    
                    guard let unwrappedSingleDictionary = castedSingleDictionary else{print("ERROR"); return}
                    
                    resultsArrayOfDictionary.append(unwrappedSingleDictionary)
                }
                
                completion(resultsArrayOfDictionary as NSArray)
        }) 
        
        task.resume()
    }
}







