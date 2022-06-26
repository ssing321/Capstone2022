//
//  PhotoLibrarySaver.swift
//

import UIKit


class PhotoLibrarySaver: NSObject {
    func writeToPhotosAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savePhoto), nil)
    }
    
    @objc func savePhoto(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        }
        else {
            print("The image was saved in the Photo Library.")
        }
    }
}


func saveImageToFile(image: UIImage, jpegQuality: CGFloat = 0.9) {
    if let data = image.jpegData(compressionQuality: jpegQuality) {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd_HH-mm-ss-SS"
        let timestamp = formatter.string(from: now)
        let filename = "photo_\(timestamp).jpg"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathname = path.appendingPathComponent(filename)
        do {
            try data.write(to: pathname)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    else {
        print("Warning, unable to create jpeg data.")
    }
}
