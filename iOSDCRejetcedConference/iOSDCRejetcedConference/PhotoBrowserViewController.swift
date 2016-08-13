//
//  PhotoBrowserViewController.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/13/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class PhotoBrowserViewController: UIViewController {
    
    @IBOutlet weak var scrollView: PhotoBrowserScrollView!
    
    var photo: Photo!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        modalPresentationStyle = .OverFullScreen
        modalTransitionStyle = .CrossDissolve
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.photo = photo
    }
}
