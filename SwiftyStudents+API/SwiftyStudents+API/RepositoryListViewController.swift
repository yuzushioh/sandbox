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
        manager.sendRequest(request: request) { [weak self] result in
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
}

