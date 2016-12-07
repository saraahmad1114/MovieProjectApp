//
//  TheDBMovieAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 11/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class TheDBMovieAPIClient {

    class func getMovieTrailerFrom(_ query: String, completion: @escaping (NSDictionary)->())
    {
        var videoInfoDictionary : NSDictionary = [:]
        
        let movieTrailerURL = "https://api.themoviedb.org/3/movie/\(query)/videos?api_key=\(Secrets.theMovieDBAPIKey)"
        
        let nsurl = URL(string: movieTrailerURL)
        
        guard let unwrappednsURL = nsurl else {print("URL DID NOT UNWRAP"); return}
        
        let request = URLRequest(url: unwrappednsURL)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            let responseDictionary = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! NSDictionary
        
                guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
                
                let resultsArray = unwrappedResponseDictionary["results"] as? NSArray
                
                guard let unwrappedResultsArray = resultsArray else {print("ERROR OCCURRED HERE"); return}
                
                let firstDictionary = unwrappedResultsArray.firstObject as? NSDictionary
                
                guard let unwrappedFirstDictionary = firstDictionary else {print("ERROR OCCURRED HERE"); return}
                
                videoInfoDictionary = unwrappedFirstDictionary
            
            completion(videoInfoDictionary)
        }) 
        task.resume()
    }

}
