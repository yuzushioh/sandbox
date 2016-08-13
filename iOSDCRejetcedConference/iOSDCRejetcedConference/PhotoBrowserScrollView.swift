//
//  PhotoBrowserScrollView.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/13/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class PhotoBrowserScrollView: UIScrollView {
    
    var photo: Photo! {
        didSet {
            imageView.image = UIImage(named: photo.photoName)
        }
    }
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.clearColor()
        imageView.userInteractionEnabled = true
        addSubview(imageView)
        
        contentSize = imageView.frame.size
        decelerationRate = UIScrollViewDecelerationRateFast
    }
}
