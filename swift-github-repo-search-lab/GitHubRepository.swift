//
//  GitHubRepository.swift
//  swift-github-repo-search-lab
//
//  Created by Tanira Wiggins on 11/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation


class GithubRepository {
    var fullName: String
    var htmlURL: URL
    var repositoryID: String
    
    init(dictionary: [String : Any]) {
        guard let
            name = dictionary["full_name"] as? String,
            let valueAsString = dictionary["html_url"] as? String,
            let valueAsURL = URL(string: valueAsString),
            let repoID = dictionary["id"] as? Int
            else { fatalError("Could not create repository object from supplied dictionary") }
        
        
        fullName = name 
        htmlURL = valueAsURL
        repositoryID = String(repoID)
    }
    
}
