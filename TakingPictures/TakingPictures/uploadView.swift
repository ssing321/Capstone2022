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
    var imageStore: UIImage!
    
    @IBAction func sliderDidSlide(_ sender: UISlider) {
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
            picker.cameraOverlayView = uploadImage
            picker.cameraOverlayView?.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: (uploadImage.image?.size.width)!, height: (uploadImage.image?.size.height)!))
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.uploadImage.image = image
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "finalView", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "finalView")
            self.show(controller, sender: self)
        }
}
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newImageUploadStore = fixOrientation(img: newImageUploadStore!)
        uploadImage.image = newImageUploadStore
        uploadImage.alpha = 0.5
    }
}
