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
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    var photo: Photo!
    var fromView: UIView!
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var currentScrollViewPoint: CGPoint = CGPointZero
    
    // MARK: - Computed property
    
    private var halfScreenHeight: CGFloat {
        return view.frame.height/2
    }
    
    private var photoBrowerShouldDismiss: Bool {
        let extraOffset = halfScreenHeight/4
        let y = currentScrollViewPoint.y
        
        return y > halfScreenHeight + extraOffset || y < halfScreenHeight - extraOffset
    }
    
    private var currentBackgroundAlpha: CGFloat {
        let y = currentScrollViewPoint.y
        let distanceFromCenter = y > halfScreenHeight ? y - halfScreenHeight : -(y - halfScreenHeight)
        let progress = 1 - (distanceFromCenter/halfScreenHeight)
        
        return max(0.5, progress)
    }
    
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
        
        setupPanGestureRecognizer()
    }
    
    private func setUIElementHidden(hidden: Bool, animated: Bool) {
        UIView.animateWithDuration(
            animated ? 0.3 : 0.0,
            animations: {
                self.closeButton.alpha = hidden ? 0 : 1
            }
        )
    }
    
    private func dismissPhotoBrowser() {
        scrollView.removeFromSuperview()
        
        animate(
            animation: {
                self.backgroundView.alpha = 0
            },
            completion: { completed in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        )
    }
    
    private func centerPhotoBrowserScrollView() {
        animate(
            animation: {
                self.scrollView.center = self.view.center
            }
        )
    }
    
    // MARK: - GestureRecognizer Methods
    
    private func setupPanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pangestureDidRecognized(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func pangestureDidRecognized(gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began, .Changed:
            setUIElementHidden(true, animated: true)
            
            let updatedScrollViewCenter = calculateScrollViewPositionWithGestureRecognizer(gestureRecognizer)
            scrollView.center = updatedScrollViewCenter
            currentScrollViewPoint = updatedScrollViewCenter
            
        case .Ended:
            setUIElementHidden(false, animated: true)
            
            if photoBrowerShouldDismiss {
                dismissPhotoBrowser()
            } else {
                centerPhotoBrowserScrollView()
            }
            
        default:
            break
        }
        
        updateBackgroundAlphaWithGestureRecognizer(gestureRecognizer)
    }
    
    private func calculateScrollViewPositionWithGestureRecognizer(gestureRecognizer: UIPanGestureRecognizer) -> CGPoint {
        let translatedPoint = gestureRecognizer.translationInView(view)
        let viewCenterCoordinate = view.center
        let updatedScrollViewCenter = CGPoint(x: viewCenterCoordinate.x, y: viewCenterCoordinate.y + translatedPoint.y)
        
        return updatedScrollViewCenter
    }
    
    private func updateBackgroundAlphaWithGestureRecognizer(gestureRecognizer: UIPanGestureRecognizer) {
        guard !photoBrowerShouldDismiss else { return }
        
        switch gestureRecognizer.state {
        case .Began, .Changed:
            self.backgroundView.alpha = currentBackgroundAlpha
        case .Ended:
            self.backgroundView.alpha = 1
        default:
            break
        }
    }
    
    private func animate(animation animation: Void -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseInOut, animations: animation, completion: completion)
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
