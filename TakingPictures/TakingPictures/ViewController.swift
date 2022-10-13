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
    
    var newImageStore: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapCameraButton() {
        //camera
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    @IBAction func didTapImportButton() {
        //importing photos
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func didTapPostButton() {
        self.newImageStore = imageView.image
        performSegue(withIdentifier: "upload", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! uploadView
        vc.newImageUploadStore = self.newImageStore
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
        UIImage else {
            return
        }
        imageView.image = image
    }

}

