//
//  firstFinal.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 10/14/22.
//

import UIKit

class firstFinal: UIViewController {

    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var navF: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
}
