//
//  SampleCode.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/28/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

protocol Sample {
    
    
    // 画面をPushするメソッド
    func pushToSearchViewController()
    func pushToProfileViewController()
    
    // 画面をModal表示するメソッド
    func presentCategorySelectViewController()
    func presentPostViewController()
    
    // 画面にViewを追加するメソッド
    func addBalloonViewOnView(view: UIView)
    func addChildViewControllerToSelf()
    
    // なにかを表示するメソッド
    func showSearchFilterView()
    func hideSearchFilterView()
    
    // 状態を管理するメソッド
    func setItemEditable(editable: Bool)
    func setButtonsHidden(hidden: Bool)
    
}

class SampleClass: UIViewController {
    
    
    var item: Item! {
        didSet {
            updateItemInformationWithItem(item)
        }
    }
    
    let actionButton = UIButton()
    let likeButton = UIButton()
    let commentButton = UIButton()
    let likeCountLabel = UILabel()
    
    
    
    
    func updateItemInformationWithItem(item: Item) {
        guard !item.isDeleted else {
            addDeletedIconView()
            return
        }
        
        commentButton.enabled = item.isClosed
        actionButton.setTitle(item.isMyItem ? "編集" : "購入", forState: .Normal)
        
        let iconName = item.isLiked ? "is_liked_icon" : "not_liked_icon"
        likeButton.setImage(UIImage(named: iconName), forState: .Normal)
        likeCountLabel.text = "\(item.likeCount)"
        likeCountLabel.hidden = !item.isLiked
    }
    
    
    
    
    
    func addDeletedIconView() {
        
    }
    
    
    
    
}


struct Item {
    var likeCount = 10
    var isDeleted = true
    var isClosed = true
    var isMyItem = true
    var isRead = true
    var isLiked = false
    var isCommented = false
}