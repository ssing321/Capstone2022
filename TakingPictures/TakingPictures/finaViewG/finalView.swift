//
//  finalView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 8/4/22.
//

import UIKit

class finalView: UIViewController {
    @IBOutlet weak var finalImagestore: UIImageView!
    var finalImage: UIImage!


    override func viewDidLoad() {
        super.viewDidLoad()
        finalImagestore.image = finalImage
    }
}
