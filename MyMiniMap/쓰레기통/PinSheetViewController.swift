//
//  PinSheetViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 26/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

class PinSheetViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    var alertName = String()
    var alertAddress = String()
    var alertImage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        lbName.text = alertName
        lbAddress.text = alertAddress
        image.image = UIImage(named: alertImage)
        print("image : \(alertImage)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
         dismiss(animated: true)
    }
    
}
