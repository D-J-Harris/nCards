//
//  textRecognition.swift
//  nCards
//
//  Created by Daniel Harris on 17/07/2018.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class textRecognitionViewController: UIViewController {
    
    //Initialise some variables
    lazy var vision = Vision.vision()
    var resultsText = ""
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var outputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectTexts(image: testImage.image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func detectTexts(image: UIImage?){
        guard let UIImage = image else {return}
        
        //Get instance of VisionTextDetector
        let textDetector = vision.textDetector()
        
        //remember to maybe orient UIImage to .up
        //image.imageOrientation = .up
        
        let image = VisionImage(image: UIImage)
        
        //Start detect
        textDetector.detect(in: image) { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                //error handling
                let errorString = error?.localizedDescription ?? "Placement error string"
                self.resultsText = "On-Device text detection failed with error: \(errorString)"
                return
            }
            
            
            self.outputText.text = features.map { feature in
//                let transformedRect = feature.frame.applying(self.transformMatrix())
//                UIUtilities.addRectangle(
//                    transformedRect,
//                    to: self.annotationOverlayView,
//                    color: UIColor.green
//                )
                return "Text: \(feature.text)"
                }.joined(separator: "\n")
        }
    }
    
    //Transforming the image
    private func transformMatrix() -> CGAffineTransform {
        guard let image = testImage.image else { return CGAffineTransform() }
        let imageViewWidth = testImage.frame.size.width
        let imageViewHeight = testImage.frame.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let imageViewAspectRatio = imageViewWidth / imageViewHeight
        let imageAspectRatio = imageWidth / imageHeight
        let scale = (imageViewAspectRatio > imageAspectRatio) ?
            imageViewHeight / imageHeight :
            imageViewWidth / imageWidth
        
        // Image view's `contentMode` is `scaleAspectFit`, which scales the image to fit the size of the
        // image view by maintaining the aspect ratio. Multiple by `scale` to get image's original size.
        let scaledImageWidth = imageWidth * scale
        let scaledImageHeight = imageHeight * scale
        let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
        let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
        
        var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }
    
    
}
