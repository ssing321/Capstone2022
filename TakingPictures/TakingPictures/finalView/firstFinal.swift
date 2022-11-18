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
    public var brightness : Float = 0.0
    public var contrast : Float = 1.0
    var filter: CIFilter? = CIFilter(name: "CIColorControls")
    
    func applyImageFilter(for image: UIImage) -> UIImage? {
            guard let sourceImage = CIImage(image: image),
            let filter = self.filter else { return nil }
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            filter.setValue(self.contrast, forKey: kCIInputContrastKey)
            filter.setValue(self.brightness, forKey: kCIInputBrightnessKey)
            guard let output = filter.outputImage else { return nil }
            guard let outputCGImage = CIContext().createCGImage(output, from: output.extent) else { return nil }
            let filteredImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
            return filteredImage
        }
    
    @IBAction func sliderValueChangeAction(_ sender: UISlider) {
        if sender.tag == 0 {
            self.brightness = sender.value
        }
        else if sender.tag == 1 {
                self.contrast = sender.value
        }
        firstImage.image = self.applyImageFilter(for: image!)
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
//        self.navigationItem.setHidesBackButton(false, animated: false)
        firstImage.image = image
    }
}
