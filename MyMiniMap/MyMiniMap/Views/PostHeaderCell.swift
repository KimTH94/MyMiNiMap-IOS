//
//  PostHeaderCell.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 09/09/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var blNickname: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lbLikeCount: UILabel!
    
    var post: Post! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        profileImage.image = UIImage(named: post.profileImage!)
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2.0
        profileImage.layer.masksToBounds = true
        mainImage.image = UIImage(named: post.mainImage!)
    
    }
}
