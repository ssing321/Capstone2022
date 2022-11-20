//
//  secondFinal.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 10/14/22.
//

import UIKit

class secondFinal: UIViewController {
    var image: UIImage? = nil
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
        secondImage.image = newUIImage;
    }
    
    
    
    @IBAction func contrastSlider(_ sender: UISlider) {
        contrastFilter.setValue(NSNumber(value: sender.value), forKey: "inputContrast")
        outputImage = contrastFilter.outputImage!;
        let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: cgimg!)
        secondImage.image = newUIImage;
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
        secondImage.image = image
        let aUIImage = secondImage.image;
        let aCGImage = aUIImage?.cgImage;
        aCIImage = CIImage(cgImage: aCGImage!)
        context = CIContext(options: nil);
        contrastFilter = CIFilter(name: "CIColorControls");
        contrastFilter.setValue(aCIImage, forKey: "inputImage")
        brightnessFilter = CIFilter(name: "CIColorControls");
        brightnessFilter.setValue(aCIImage, forKey: "inputImage")
    }
}
