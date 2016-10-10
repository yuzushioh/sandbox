//
//  ViewController.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/6/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import APIKit

class RepositoryListViewController: UITableViewController {

    fileprivate let manager = APIManager<GithubService.SearchRepositories>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshElement()
    }
    
    fileprivate func refreshElement() {
        let request = GithubService.SearchRepositories(query: "swift")
        manager.sendRequest(request: request) { [weak self] in
            if let error = self?.manager.error {
                print(error)
            }
            
            self?.tableView.reloadData()
        }
    }
}

extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepositoryViewCell
        let repository = manager.elements[indexPath.row]
        
        cell.repository = repository
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = manager.elements[indexPath.row]
        showRepository(repository: repository)
    }
    
    fileprivate func showRepository(repository: Reposirory) {
        let alertViewContoller = UIAlertController(title: repository.name, message: repository.description, preferredStyle: .alert)
        alertViewContoller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertViewContoller, animated: true, completion: nil)
    }
}

