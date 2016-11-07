//
//  ViewController.swift
//  swift-github-repo-search-lab
//
//  Created by Ian Rahman on 10/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire



class TableViewController: UITableViewController {
    var store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        store.getRepositoriesWithCompletion {
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func searchButton(_ sender: AnyObject) {
        alertMessage()
    }
    
    func alertMessage() {
        let alertController = UIAlertController(title: "Enter Repo Name", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        let action = UIAlertAction(title: "Search", style: .default) { (_) in
            guard let inputWords = alertController.textFields?[0].text else { return }
            
            self.store.getSearchRepos(name: inputWords) { _ in
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
                
            }
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
 
        }


        
        
        
        
        
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return  1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return store.repositories.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GithubCell", for: indexPath)
            let visualRow = store.repositories[indexPath.row]
            cell.textLabel?.text = visualRow.fullName
            return cell
        }
        

}
