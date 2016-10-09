//
//  RepositoryViewCell.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class RepositoryViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var repository: Reposirory? {
        didSet {
            guard let repository = repository else {
                return
            }
            
            profileImageView.setImage(from: repository.owner.avatarURL)
            usernameLabel.text = repository.owner.name
            descriptionLabel.text = repository.name
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        usernameLabel.text = nil
        descriptionLabel.text = nil
    }
}
