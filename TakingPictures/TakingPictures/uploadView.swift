//
//  uploadView.swift
//  TakingPictures
//
//  Created by Shaswat Singh on 7/2/22.
//

import UIKit


class uploadView: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate {

    @IBOutlet weak var uploadImage: UIImageView!
    var newImageUploadStore: UIImage!
    var finalvalue: Int = 0
    
    @IBAction func sliderDidSlide(_ sender: UISlider) {
        let value = sender.value
        uploadImage.alpha = CGFloat(value)
        finalvalue = Int(value)
    }
    
    @IBAction func startCameraLiveOverlay(_sender : UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.cameraOverlayView = uploadImage
            self.present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        uploadImage.contentMode = .scaleAspectFit
        uploadImage.image = image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage.image = newImageUploadStore
        uploadImage.alpha = 0.5
    }
}
