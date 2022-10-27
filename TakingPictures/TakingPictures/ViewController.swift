//
//  ViewController.swift
//  TakingPictures
//
//  Created by Catherine Nguyen on 6/28/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var Lbutton: UIButton!
    @IBOutlet var Cbutton: UIButton!
    @IBOutlet var Ibutton: UIButton!
    
    var firstImageStore: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Lbutton.layer.cornerRadius = 20.0
        Cbutton.layer.cornerRadius = 20.0
        Ibutton.layer.cornerRadius = 20.0
        Lbutton.alpha = 0
    }
    
    
    @IBAction func didTapCameraButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
        Lbutton.alpha = 1
    }
    @IBAction func didTapImportButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        Lbutton.alpha = 1
    }
    
    @IBAction func didTapPostButton() {
        self.firstImageStore = imageView.image
        performSegue(withIdentifier: "upload", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! uploadView
        vc.firstImageInSecondView = self.firstImageStore
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
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        imageView.image = image
        imageView.image = fixOrientation(img: imageView.image!)
    }
}



