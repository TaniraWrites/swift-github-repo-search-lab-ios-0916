//
//  GithubAPIClient.swift
//  swift-github-repo-search-lab
//
//  Created by Tanira Wiggins on 11/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire

class GithubAPIClient {
    
    class func searchRepo(name:String, completion: @escaping ([[String: Any]]) -> Void) {
        
        Alamofire.request("\(Secrets.githubAPIURL)/search/repositories?q=\(name)").responseJSON { (response) in // lines 28-36 with Alamofire
            guard let searchResponse = response.result.value as? [String:Any] else { return}
            let newSearch = searchResponse["items"] as! [[String:Any]]
            
            completion(newSearch)
        }
    
    }
    
    
    
    
    
    class func getRepositoriesWithCompletion(_ completion: @escaping ([Any]) -> ()) {
        let urlString = "\(Secrets.githubAPIURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let differentArray = responseArray {
                    completion(differentArray)
                }
            }
        })
        task.resume()
    }
    
    
    // class func starRepository -> URL Request and then -> request.method
    
    
    
    
    class func checkIfRepositoryIsStarred(fullName: String, completion: @escaping (Bool)-> Void) {
        var isStarred = false
        
        let urlString = "\(Secrets.githubAPIURL)/user/starred/\(Secrets.name)?access_token=\(Secrets.personalAccessToken)"
        
        let url = URL(string: urlString)
        guard let unwrappedURL = url else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            let httpresponse = response as! HTTPURLResponse
            
            if httpresponse.statusCode == 204 {
                isStarred = true
            } else if httpresponse.statusCode == 404 {
                isStarred = false
            }
            completion(isStarred)
        }
        
        task.resume()
    }
    
    
    class func starRepository(name:String, completion: @escaping (Bool)->Void) {
        var success = false
        let urlString = "\(Secrets.githubAPIURL)/user/starred/\(Secrets.name)?access_token=\(Secrets.personalAccessToken)"
        
        let url = URL(string: urlString)
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
        request.httpMethod = "PUT"
        request.addValue("0", forHTTPHeaderField: "Content-Length")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 204 {
                success = true
            } else if httpresponse.statusCode == 404 {
                success = false
            }
            completion(success)
        }
        
        task.resume()
    }
    
    class func unstarRepository(name:String, completion: @escaping (Bool) -> Void) {
        var success = false
        let urlString = "\(Secrets.githubAPIURL)/user/starred/\(Secrets.name)?access_token=\(Secrets.personalAccessToken)"
        
        let url = URL(string: urlString)
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
        request.httpMethod = "DELETE"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 204 {
                success = true
            } else if httpresponse.statusCode == 404 {
                success = false
            }
            completion(success)
        }
        
        task.resume()
        
    }



}









