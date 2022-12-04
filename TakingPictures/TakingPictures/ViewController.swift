//
//  ViewController.swift
//  TakingPictures
//
//  Created by Catherine Nguyen on 6/28/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var Lbutton: UIButton!//live button
    @IBOutlet var Cbutton: UIButton!//capture button
    @IBOutlet var Ibutton: UIButton!//import button
    
    var checkUploadOrClicker: Int! //using checkUploadOrClicker to check if image has been clicked or uploaded and then use                             it add constraints
    
    var firstImageStore: UIImage! //for storing and seguing the first image
    
    override func viewDidLoad() {
        //when the first view loads
        super.viewDidLoad()
        Lbutton.layer.cornerRadius = 20.0
        Cbutton.layer.cornerRadius = 20.0
        Ibutton.layer.cornerRadius = 20.0
        Lbutton.alpha = 0 //hiding the live button till the user has uploaded or captured the first image
    }
    
    //for clicking the first image using the UIImagePickerController
    @IBAction func didTapCameraButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        Lbutton.alpha = 1 //showing the live button now
        checkUploadOrClicker = 1
    }
    //for uploading the first image using the UIImagePickerController
    @IBAction func didTapImportButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        Lbutton.alpha = 1
        checkUploadOrClicker = 0
    }
    //when live button is clicked go to upload view
    @IBAction func didTapPostButton() {
        self.firstImageStore = imageView.image
        performSegue(withIdentifier: "upload", sender: self)
    }
    // go to upload view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! uploadView
        vc.firstImageInSecondView = self.firstImageStore
    }
    // some contraints to fix first image orientation
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
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                
        UIImage
            else {
            return
        }
        imageView.image = image
//        imageView.image = fixOrientation(img: imageView.image!)
        
        //if the image is uploaded
        if(checkUploadOrClicker == 0){
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
        }
    }
}
