//
//  PhotoViewCell.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/13/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            imageView.image = UIImage(named: photo.photoName)
        }
    }
}
