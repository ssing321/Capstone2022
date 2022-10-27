//
//  uploadView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 7/2/22.
//

import UIKit


class uploadView: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    @IBOutlet weak var sliderAlpha: UISlider!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var UILabel: UILabel!
    
    var firstImageInSecondView: UIImage!
    var finalvalue: Int = 0
    var imageStore: UIImage!
    var secondImageStore: UIImage!
    
    var globalValue: Int = Int(0.5)
    
    
    @IBAction func sliderDidSlide(_ sender: UISlider)
    {
        let value = sender.value
        uploadImage.alpha = CGFloat(exactly: value)!
        UILabel.text = String(sliderAlpha.value*100)
        finalvalue = Int(value)
        globalValue = finalvalue
        imageStore = uploadImage.image
    }
    
    @IBAction func startCameraLiveOverlay(_sender : UIBarButtonItem) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            let myView = UIView()
            uploadImage.frame = CGRect(x: 0, y: 118, width: 420, height: 560)
            myView.addSubview(uploadImage)
            picker.cameraOverlayView!.addSubview(myView)
            
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
        
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "finalView", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "finalView") as! UITabBarController?
            let secondVC = (controller?.self.viewControllers?[0])! as! secondFinal
            secondVC.image = self.secondImageStore
            let firstVC = (controller?.self.viewControllers?[1])! as! firstFinal
            firstVC.image = self.firstImageInSecondView
            self.show(controller!, sender: self)
        }
    }
    
    
//if user cancels on live view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Null")
        self.dismiss(animated: true)
//        uploadImage.image = nil
//        uploadImage.isHidden = false
//        super.viewDidLoad()
//        uploadImage.image = self.firstImageInSecondView
//        uploadImage.alpha = CGFloat(self.globalValue)
        self.viewDidLoad()
        print(uploadImage.image)
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage.image = firstImageInSecondView
        uploadImage.alpha = 0.5
        UILabel.text = String(Int(50))
    }
}
