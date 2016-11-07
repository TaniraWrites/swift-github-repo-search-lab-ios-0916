//
//  DataStore.swift
//  swift-github-repo-search-lab
//
//  Created by Tanira Wiggins on 11/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    fileprivate init() {}
    
    var repositories:[GithubRepository] = []
 
    
    func getSearchRepos(name:String ,completion: @escaping ()->()) {
        GithubAPIClient.searchRepo(name: name) { (searchArray) in
            self.repositories.removeAll()
            for repo in searchArray {
                self.repositories.append(GithubRepository(dictionary: repo))
            }
    
        
        }
        completion()
    }
    
    func getRepositoriesWithCompletion(_ completion: @escaping () -> ()) {
        GithubAPIClient.getRepositoriesWithCompletion { (reposArray) in
            self.repositories.removeAll()
            
            for dictionary in reposArray {
//                guard let repo = dictionary as! [String : Any]
                self.repositories.append(GithubRepository(dictionary: dictionary as! [String : Any]))
            //    print(self.repositories)
            }
            completion()
        }
    }

    func toggleStarStatus(name: String , completion: @escaping (Bool) ->()) {
        
        GithubAPIClient.checkIfRepositoryIsStarred(fullName: name) { (isStarred) in
            
            if isStarred == true {
                GithubAPIClient.unstarRepository(name: name, completion: { (success) in
                    completion(success)
                })
            } else if isStarred == false {
                GithubAPIClient.starRepository(name: name, completion: { (success) in
                    completion(success)
                })
            }
        }
        
    }

    

}

