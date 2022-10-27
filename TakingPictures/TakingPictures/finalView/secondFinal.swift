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
        var dialogMessage = UIAlertController(title: "Saved", message: "Second Image Saved", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }

    @IBAction func pressShareSecond(_ sender: UIBarButtonItem) {
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var nacS: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(false, animated: false)
        secondImage.image = image
    }
}
