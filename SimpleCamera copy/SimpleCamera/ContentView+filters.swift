//
//  ContentView+twirl.swift
//  SimpleCamera
//
//  Created by Loren Olson on 3/21/22.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins



extension ContentView {
    func filterFork() {
        guard let background = inputImage else { return }
        guard let foreground = fork else { return }
        guard var sourceFG = CIImage(image: foreground) else { return }
        guard let sourceBG = CIImage(image: background) else { return }
        let context = CIContext()
        
        let currentFilter = CIFilter.sourceOverCompositing()
        
        print("background size = \(background.size)")
        print("foreground size = \(foreground.size)")
        print("background scale = \(background.scale)")
        print("foreground scale = \(foreground.scale)")
        let dx = (background.size.width - foreground.size.width) / 2.0
        let dy = (background.size.height - foreground.size.height) / 2.0
        var transform = CGAffineTransform(translationX: dx, y: dy)
        
        /*
         This transform works with the images in the simulator photo Album,
         apparently, they have been transformed to have what I will call
         a natural ImageOrientation, regardless of their appearance. They
         all are oriented "up" according to UIImageOrientation.
         
         However, see this note from the UIImageOrientation docs:
         "For example, an iOS device camera always encodes pixel data in the
         camera sensor's native landscape orientation, along with metadata
         indicating the camera orientation. When UIImage loads a photo shot
         in portrait orientation, it automatically applies a 90° rotation
         before displaying the image data, and the image's imageOrientation
         value of right indicates that this rotation has been applied."
         
         So, if we take an image in portrait orientation - which is how
         I setup this demo - then the imageOrientation is going to be
         "right".
         
         To make the composite correct for this case, we need a different
         transformation to rotate the Logo 90 degrees, and transform it
         to the center of the image. The numbers used are a little confusing,
         but remember the note above, that the captured image is actually
         rotated 90 degrees compared to how it is being displayed.
         
         Another note: I'm only handling this case for a portrait shot.
         There are other possible values for UIImageOrientation (see the
         docs), so if you wanted to support any orientation, you need
         some more code to support those possibilities.
        */
        if background.imageOrientation == .right {
            print("background imageOrientation right")
            let dx: CGFloat = background.size.height / 2.0 + foreground.size.height / 2.0
            let dy: CGFloat = background.size.width / 2.0 - foreground.size.width / 2.0
            transform = CGAffineTransform(translationX: dx, y: dy)
            transform = transform.rotated(by: (.pi / 2.0))
        }
        sourceFG = sourceFG.transformed(by: transform)
        
        currentFilter.setValue(sourceFG, forKey: kCIInputImageKey)
        currentFilter.setValue(sourceBG, forKey: kCIInputBackgroundImageKey)
        
        guard let outputImage = currentFilter.outputImage else {
            print("outputImage failed")
            return
        }
        if let resultImage = context.createCGImage(outputImage, from: sourceBG.extent) {
            let resultUI = UIImage(cgImage: resultImage, scale: 1.0, orientation: background.imageOrientation)
            hero = Image(uiImage: resultUI)
            inputImage = resultUI
        }
    }
    
    func filterTwirl() {
        performSimpleFilter(setup: { beginImage in
            
            guard let beginImage = beginImage else {
                return CIFilter.twirlDistortion()
            }
            print("extent size \(beginImage.extent.size.width),\(beginImage.extent.size.height)")
            
            let extent = beginImage.extent
            let extentCenter = CGPoint(x: extent.width / 2.0, y: extent.height / 2.0)
            let radius = (min(extent.width, extent.height) / 2.0) * 0.9
            
            let currentFilter = CIFilter.twirlDistortion()
            currentFilter.inputImage = beginImage
            currentFilter.radius = Float(radius)
            currentFilter.center = extentCenter
            currentFilter.angle = 3.14
            return currentFilter
        })
    }

    func filterSepia() {
        performSimpleFilter(setup: { beginImage in
            let currentFilter = CIFilter.sepiaTone()
            currentFilter.inputImage = beginImage
            currentFilter.intensity = 1
            return currentFilter
        })
    }
    
    
    func filterGaussianBlur() {
        performSimpleFilter(setup: { beginImage in
            let currentFilter = CIFilter.gaussianBlur()
            currentFilter.inputImage = beginImage
            currentFilter.radius = 50
            return currentFilter
        })
    }
    
    
    func performSimpleFilter(setup: (CIImage?) -> CIFilter) {
        guard let img = inputImage else { return }
        guard let beginImage = CIImage(image: img) else { return }
        let context = CIContext()
        let currentFilter = setup(beginImage)
        guard let outputImage = currentFilter.outputImage else {
            print("outputImage failed")
            return
        }
        if let resultImage = context.createCGImage(outputImage, from: beginImage.extent) {
            let resultUI = UIImage(cgImage: resultImage, scale: 1.0, orientation: img.imageOrientation)
            hero = Image(uiImage: resultUI)
            inputImage = resultUI
        }
    }
    
}
