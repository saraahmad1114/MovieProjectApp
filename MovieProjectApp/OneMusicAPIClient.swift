//
//  OneMusicAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class OneMusicAPIClient
{
    class func getArtistAndSongsInformationWith(title: String, artist: String, countNum: Int, completion:(NSDictionary)-> ())
    {
        var musicDictionary : [String : String] = [:]
        
        let countNum = 1
        
        var musicURL = "http://api.onemusicapi.com/20150623/release?title=\(title)&artist=\(artist)&user_key=\(Secrets.musicAPIKey)&inc=images&maxResultCount=\(countNum)"
        
        musicURL = musicURL.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let nsurl = NSURL(string: musicURL)
        
        guard let unwrappedNSURL = nsurl else {print("ERROR OCCURRED HERE!"); return}
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: unwrappedNSURL)
        
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
        guard let unwrappedData = data else {print("ERROR OCCURRED HERE"); return}
        
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSArray
            {
                guard let unwrappedResponseArray = responseArray else {print("ERROR OCCURRED HERE"); return}
                
                let dictionaryInArray = unwrappedResponseArray[0] as? [String : String]
                
                guard let unwrappedDictionaryInArray = dictionaryInArray else {print("AN ERROR OCCURRED HERE!"); return}

                musicDictionary = unwrappedDictionaryInArray
            }
        completion(musicDictionary)
        }
    task.resume()
    }

}
