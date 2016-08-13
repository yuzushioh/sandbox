//
//  PhotoListViewController.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/13/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class PhotoListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let photos = Photo.photos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var collectionView: UICollectionView! {
        get {
            return super.collectionView
        }
        
        set {
            super.collectionView = newValue
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PhotoViewCell
    
        cell.photo = photos[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PhotoBrowserViewController") as! PhotoBrowserViewController
        
        vc.photo = photos[indexPath.row]
        presentViewController(vc, animated: true, completion: nil)
    }
    
    private let numberOfRows: Int = 3
    private let minimumLineSpacing: CGFloat = 1
    private let minimumInteritemSpacing: CGFloat = 1
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let viewWidth = view.frame.width - (4 * minimumLineSpacing)
        let width = viewWidth / CGFloat(numberOfRows)
        
        return  CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
