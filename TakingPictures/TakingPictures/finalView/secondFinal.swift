//
//  secondFinal.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 10/14/22.
//

import UIKit

class secondFinal: UIViewController {
    
    var image: UIImage? = nil

    @IBAction func pressSaveSecond(_ sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(secondImage.image!, nil, nil, nil)
    }

    @IBAction func pressShareSecond(_ sender: UIBarButtonItem) {
    }

    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var nacS: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: false)
        secondImage.image = image
    }
}
