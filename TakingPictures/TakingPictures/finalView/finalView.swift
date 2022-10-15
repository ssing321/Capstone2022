//
//  finalView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 10/14/22.
//

import UIKit

class finalView: UITabBarController {
    @IBOutlet var secondImage: UIImageView!
    var image: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
 
