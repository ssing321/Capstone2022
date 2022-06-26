//
//  ViewController.swift
//  OverlayCameraApp
//
//  Created by Catherine Nguyen on 6/20/22.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraPreview: UIImageView!
    
    @IBOutlet weak var imageLibrary: UIButton!
    @IBOutlet weak var photoLibraryPreview: UIImageView!
    
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        checkPermissions()
        
    }
    
    @IBAction func tappedCameraButton(_ sender: Any) {
        //initializing the camera
        let picker = UIImagePickerController()
        picker.sourceType = .camera //we're going to use the camera aspect
        picker.allowsEditing = true //this will let us edit and crop the image
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func tappedLibraryButton(_ sender: Any) {
        //initialize the photo library and it will open it up
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    //check all the permissions that are needed in order to get photos from the library
    
    func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
        })
    }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        }
        else {
                PHPhotoLibrary
                    .requestAuthorization(requestAuthorizationHandler)
            }
        }
    
    //checks to see if we have access
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("Access granted to use Photo library")
        }
        else {
            print("We don't have access to your photos")
        }
    }
    
    
    
    
    //if the user chooses to pick the image that was taken it would add it to the UIImage view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker.sourceType == .photoLibrary {
            photoLibraryPreview?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        else {
            cameraPreview?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}



