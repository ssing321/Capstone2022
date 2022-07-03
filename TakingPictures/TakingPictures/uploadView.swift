//
//  uploadView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 7/2/22.
//

import UIKit


class uploadView: UIViewController {

    @IBOutlet weak var uploadImage: UIImageView!
    var newImageUploadStore: UIImage!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            uploadImage.image = newImageUploadStore
    }
}
