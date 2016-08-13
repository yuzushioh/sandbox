//
//  PhotoListViewController.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/13/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class PhotoListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var titleToastView: UIView!
    
    let photos = Photo.photos
    
    private let numberOfRows: Int = 3
    private let minimumLineSpacing: CGFloat = 1
    private let minimumInteritemSpacing: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showToastView()
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { 
            self.hideToastView()
        }
    }

    override var collectionView: UICollectionView! {
        get {
            return super.collectionView
        }
        
        set {
            super.collectionView = newValue
        }
    }
    
    private func showToastView() {
        guard !titleToastView.isDescendantOfView(collectionView) else { return }
        
        titleToastView.center.x = collectionView.bounds.midX
        titleToastView.frame.origin.y = collectionView.frame.origin.y + 10.0
        
        titleToastView.alpha = 0.0
        collectionView.addSubview(titleToastView)
        
        animate(
            animation: {
                self.titleToastView.alpha = 1.0
            }
        )
    }
    
    private func hideToastView() {
        guard titleToastView.isDescendantOfView(collectionView) else { return }
        titleToastView.alpha = 1.0
        
        animate(
            animation: {
                self.titleToastView.alpha = 0.0
            },
            completion: { completed in
                self.titleToastView.removeFromSuperview()
            }
        )
    }
    
    private func animate(animation animation: Void -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseInOut, animations: animation, completion: completion)
    }
}

extension PhotoListViewController {
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PhotoViewCell
        
        vc.photo = photos[indexPath.row]
        vc.fromView = cell
        presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
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
