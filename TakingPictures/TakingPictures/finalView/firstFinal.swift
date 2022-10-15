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
    
    @IBAction func pressSaveFirst(_ sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(firstImage.image!, nil, nil, nil)
        var dialogMessage = UIAlertController(title: "Saved", message: "First Image Saved", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)

    }
 
    @IBAction func pressShareFirst(_ sender: Any) {
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
        }
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: false)
        firstImage.image = image
    }
}
