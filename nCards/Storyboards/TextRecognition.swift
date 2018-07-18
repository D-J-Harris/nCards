//
//  TextRecognition.swift
//  nCards
//
//  Created by Daniel Harris on 18/07/2018.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TextRecognition {
    
    //Initialise some variables
    
    let vision = Vision.vision()
    var resultsText = "here"
    
    
    func detectTexts(image: UIImage?, completion: @escaping (String) -> ()) {

        guard let uiimage = image else {return}
        
        //Get instance of VisionTextDetector
        let textDetector = vision.textDetector()
        
        //remember to maybe orient UIImage to .up
        //image.imageOrientation = .up
        
        let image = VisionImage(image: uiimage)
        
        //Start detect
        textDetector.detect(in: image) { (features, error) in
            
            guard error == nil, let features = features, !features.isEmpty else {
                //error handling
                let errorString = error?.localizedDescription ?? "Placement error string"
                self.resultsText = "On-Device text detection failed with error: \(errorString)"
                return
            }
            
            print(features)
            
            let testText = features.map { feature in
                
                return "Text: \(feature.text)"
                
                }.joined(separator: "\n")
            
            self.resultsText = testText
            completion(self.resultsText)
        }
        
        print(resultsText)
    }
}

