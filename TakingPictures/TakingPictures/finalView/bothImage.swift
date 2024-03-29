//
//  bothImage.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 11/16/22.
//

import UIKit

class bothImage: UIViewController {
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    var firstImageL: UIImage?
    var secondImageL: UIImage?
    
    //for sharing both the images together
    @IBAction func shareBothImages(_ sender: Any) {
        let imageToShare = [ firstImageL!, secondImageL! ] //sharing together
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding both images to both image views 
        imageOne.image = firstImageL
        imageTwo.image = secondImageL
        // set observer for UIApplication.willEnterForegroundNotification
    }
}
