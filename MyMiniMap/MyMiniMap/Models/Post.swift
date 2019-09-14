//
//  Post.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 09/09/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

protocol TableViewNew {
    func onClickCell(index: Int)
    func onLikeButtonClick(result: String)
}

class Post: UITableViewCell{
    
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var proFileImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lbLikeCount: UILabel!
    
    var cellDelegate: TableViewNew?
//    var index: IndexPath?
    var index: Int = 0
    var result: String = ""
    var state: Post?
    
    @IBAction func btnClicked(_ sender: UIButton) {
        cellDelegate?.onClickCell(index: index)
    }
    
    @IBAction func btnPinClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        
    }
    @IBAction func btnLikeClicked(_ sender: Any) {
    }
    
    @IBAction func btnLickClicked(_ sender: UIButton) {
        cellDelegate?.onLikeButtonClick(result: result)
    }
    
}
