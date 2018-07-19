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
                
                return "\(feature.text)"
                
                }.joined(separator: " ")
            
            self.resultsText = testText
            completion(self.resultsText)
        } //end detect
    }
    
    func linguisticTagger(_ allWords: String) {
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]
        let schemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
        let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
        tagger.string = allWords
        tagger.enumerateTags(in: NSMakeRange(0, (allWords as NSString).length), scheme: NSLinguisticTagScheme.nameTypeOrLexicalClass, options: options) { (tag, tokenRange, _, _) in
            let token = (allWords as NSString).substring(with: tokenRange)
            if tag?.rawValue == "OrganizationName" {
                print("Organisation: \(token)")
            }
            if tag?.rawValue == "PersonalName" {
                print("Name: \(token)")
            }
        }
    }
}

