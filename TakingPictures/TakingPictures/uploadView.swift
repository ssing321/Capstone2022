//
//  uploadView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 7/2/22.
//

import UIKit


class uploadView: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImage: UIImageView!
    
    
    var firstImageInSecondView: UIImage!
    var finalvalue: Int = 0
    var imageStore: UIImage!
        
    @IBAction func sliderDidSlide(_ sender: UISlider)
    {
        let value = sender.value
        uploadImage.alpha = CGFloat(exactly: value)!
        finalvalue = Int(value)
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

            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "mediaPickerDidCancel"), object:nil, queue:nil, using: { note in
                self.uploadImage.image = self.firstImageInSecondView
            })
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object:nil, queue:nil, using: { note in
                //only the second image
                picker.cameraOverlayView = nil
            
                //both images in one view
//                self.uploadImage.frame = picker.view.frame
//                myView.addSubview(self.uploadImage)
//                picker.cameraOverlayView!.addSubview(myView)
            })
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidRejectItem"), object:nil, queue:nil, using: { note in
                picker.cameraOverlayView = self.uploadImage
                
            })

            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "finalView", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "finalView")
            self.show(controller, sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage.image = firstImageInSecondView
        uploadImage.alpha = 0.5
    }
}
