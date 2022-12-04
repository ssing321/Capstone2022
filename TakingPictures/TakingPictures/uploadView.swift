//
//  uploadView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 7/2/22.
//

import UIKit


class uploadView: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var sliderAlpha: UISlider! //storing opacity slider value
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var UILabel: UILabel!
    
    var firstImageInSecondView: UIImage!
    var finalvalue: Int = 0
    var imageStore: UIImage!
    var secondImageStore: UIImage! //for storing the second image
    var globalValue: Int = Int(0.5) //inital alpha value for the opacity slider
    
    var storeImageCheck : UIImage!
        
    //acion if user slide
    @IBAction func sliderDidSlide(_ sender: UISlider)
    {
        let value = sender.value
        uploadImage.alpha = CGFloat(exactly: value)!
        UILabel.text = String(round(sliderAlpha.value*100))
        finalvalue = Int(value)
        globalValue = finalvalue
        imageStore = uploadImage.image
    }
    //if the camera icon is clicked go to live overlay
    @IBAction func startCameraLiveOverlay(_sender : UIBarButtonItem) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            let myView = UIView()
            uploadImage.frame = CGRect(x: 0, y: 118, width: 420, height: 560) //adjusting the frame according to the camera
            myView.addSubview(uploadImage) //myView created to add upload image
            picker.cameraOverlayView!.addSubview(myView) //adding as a subview over the camera
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object:nil, queue:nil, using: { note in
                //only the second image
                picker.cameraOverlayView = nil
            })
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidRejectItem"), object:nil, queue:nil, using: { note in
                picker.cameraOverlayView = self.uploadImage
            })
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        secondImageStore = image
        //seguing to the final view when finished picked image
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "finalView", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "finalView") as! UITabBarController? //sending all the three images on our three tabs on the final view
            let secondVC = (controller?.self.viewControllers?[0])! as! secondFinal
            secondVC.image = self.secondImageStore //sending second image to secondFinal
            let firstVC = (controller?.self.viewControllers?[1])! as! firstFinal
            firstVC.image = self.firstImageInSecondView //sending first image to firstFinal
            let bothVC = (controller?.self.viewControllers?[2])! as! bothImage
            bothVC.secondImageL = self.secondImageStore
            bothVC.firstImageL = self.firstImageInSecondView
            self.show(controller!, sender: self)
            }
    }
    
    //BUG unable to fix
    //if user cancels on live view
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
////        uploadImage.removeFromSuperview()
//        uploadImage.image = storeImageCheck
//        uploadImage.alpha = CGFloat(0.5)
//        print("appear")
//
//    }


    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        storeImageCheck = firstImageInSecondView
        uploadImage.image = firstImageInSecondView
        uploadImage.alpha = 0.5 //initial opacity
        UILabel.text = String(Int(50.0))
        uploadImage.contentMode = .scaleAspectFit
        uploadImage.clipsToBounds = true
    }
    
}
