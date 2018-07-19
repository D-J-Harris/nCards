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
//        uiimage.imageOrientation = .up
        
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
            
            let testText = features.map { feature in
                
                return "\(feature.text)"
                
                }.joined(separator: " ")
            
            self.resultsText = testText
            completion(self.resultsText)
        }
        //end detect
    }
    
    func linguisticTagger(_ input: String) {
        
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]
        let range = NSRange(location: 0, length: input.utf16.count)
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
        
        //for email case
        var allWords = [String]()
        allWords = input.components(separatedBy: " ")
        
        //Combine numbers whitespaced in cell number
        for i in 0...allWords.count-1 {
            if numberOfIntInString(string: allWords[i]) > 2 && numberOfIntInString(string: allWords[i+1]) > 2 {
                allWords[i+1] = allWords[i]+allWords[i+1]
                allWords[i] = ""
            }
        }
        
        //name and company
        tagger.string = input
        tagger.setOrthography(NSOrthography.defaultOrthography(forLanguage: "en"), range: range)
        tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { (tag, tokenRange, stop) in
            if let tag = tag, tags.contains(tag) {
                let token = (input as NSString).substring(with: tokenRange)
                if tag.rawValue == "OrganizationName" {
                    print("Organisation: \(token)")
                }
                if tag.rawValue == "PersonalName" {
                    print("Name: \(token)")
                }
            }
        }
        //number and email
        for word in allWords {
            if word.contains("@") {
                print("Email: \(word)")
            }
            if numberOfIntInString(string: word) > 7 {
                print("Number: \(word)")
            }
        }
    }
    
    //supporting function
    func numberOfIntInString(string: String) -> Int {
        var counter = 0
        for char in string {
            if let _ = Int(String(char)) {
                counter += 1
            }
        }
        return counter
    }
}

