//
//  PinSheetService.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 26/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import Foundation
import UIKit

class PinSheetService {
    func alert(Name: String, Address: String, image: String) -> PinSheetViewController {
        let storyboard = UIStoryboard(name: "PinSheetstoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! PinSheetViewController
        
        alertVC.alertName = Name
        alertVC.alertAddress = Address
        alertVC.alertImage = image
        return alertVC
    }
}
