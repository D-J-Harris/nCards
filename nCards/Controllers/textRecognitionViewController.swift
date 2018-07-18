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
    var resultsText: String = ""
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var outputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectTexts(image: testImage.image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func detectTexts(image: UIImage?) {
        guard let UIImage = image else {return}
        
        //Get instance of VisionTextDetector
        let textDetector = vision.textDetector()
        
        let image = VisionImage(image: UIImage)
        
        //Start detect
        textDetector.detect(in: image) { (features, error)  in
            guard error == nil, let features = features, !features.isEmpty else {
                //error handling
                let errorString = error?.localizedDescription ?? "Error"
                self.outputText.text = "On-Device text detection failed with error: \(errorString)"
                return
            }
            
            self.resultsText = features.map { feature in
                return "\(feature.text)"
                }.joined(separator: " ")
            print("In closure \(self.resultsText)")
            self.outputText.text = self.resultsText
        }
        print("After closure \(resultsText)")
    }
 
    func findContactInfo(_ allWords: String) {
        
        //initialise linguistic tagger instance variables
        let schemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
        tagger.string = allWords
        
        let range = NSRange(location: 0, length: (allWords as NSString).length)

        tagger.enumerateTags(in: range, scheme: .nameType, options: options) { tag, tokenRange, _, _  in
            let token = (allWords as NSString).substring(with: tokenRange)
            print("\(token): \(tag)")
        }
    }

}
