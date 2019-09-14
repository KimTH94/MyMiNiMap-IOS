//
//  SEQ_OwnerViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 11/09/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

class SEQ_OwnerViewController: UIViewController {

    @IBOutlet weak var lbText: UILabel!
    
    var SEQ_Owner: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbText.text! = " gg \(SEQ_Owner)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
