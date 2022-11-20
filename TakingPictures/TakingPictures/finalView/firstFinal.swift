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
    var storeImageOne: UIImage?
    var aCIImage = CIImage();
    var contrastFilter: CIFilter!;
    var brightnessFilter: CIFilter!;
    var context = CIContext();
    var outputImage = CIImage();
    var newUIImage = UIImage();
 
    @IBAction func brightnessSlider(_ sender: UISlider) {
        brightnessFilter.setValue(NSNumber(value: sender.value), forKey: "inputBrightness");
        outputImage = brightnessFilter.outputImage!;
        let imageRef = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: imageRef!)
        firstImage.image = newUIImage;
    }
    
    @IBAction func contrastSlider(_ sender: UISlider) {
        contrastFilter.setValue(NSNumber(value: sender.value), forKey: "inputContrast")
        outputImage = contrastFilter.outputImage!;
        let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: cgimg!)
        firstImage.image = newUIImage;
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
        firstImage.image = image
        let aUIImage = firstImage.image;
        let aCGImage = aUIImage?.cgImage;
        aCIImage = CIImage(cgImage: aCGImage!)
        context = CIContext(options: nil);
        contrastFilter = CIFilter(name: "CIColorControls");
        contrastFilter.setValue(aCIImage, forKey: "inputImage")
        brightnessFilter = CIFilter(name: "CIColorControls");
        brightnessFilter.setValue(aCIImage, forKey: "inputImage")
    }
}
