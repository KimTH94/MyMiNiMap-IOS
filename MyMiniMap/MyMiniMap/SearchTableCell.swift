//
//  SearchTableCell.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 22/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    @IBOutlet var lbNickname: UILabel!
    @IBOutlet var lbEmail: UILabel!
    
    @IBOutlet weak var TableImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
