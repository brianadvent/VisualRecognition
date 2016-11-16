//
//  ViewController.swift
//  VisualRecognition
//
//  Created by Brian Advent on 16/11/2016.
//  Copyright © 2016 Brian Advent. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import AlamofireImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    let apiKey = "01e37c8d65f8894103ff5599ac7164d07233b0b1"
    let version = "2016-11-16"

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    @IBAction func getImage(_ sender: Any) {
        let button = sender as! UIBarButtonItem
        button.isEnabled = false
        
        
        let randomNumber = Int(arc4random_uniform(1000) )
        
        let url = URL(string: "https://unsplash.it/400/700?image=\(randomNumber)")!
        
        imageView.af_setImage(withURL: url)
        
        
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let failure = {(error:Error) in
        
            DispatchQueue.main.async {
                self.navigationItem.title = "Image could not be processed"
                button.isEnabled = true
            }
            
            
            print(error)
        
        }
        
        let recogURL = URL(string: "https://unsplash.it/50/100?image=\(randomNumber)")!
        
        visualRecognition.classify(image: recogURL.absoluteString, failure: failure) { classifiedImages in
        
            if let classifiedImage = classifiedImages.images.first {
                print(classifiedImage.classifiers)
                
                if let classification = classifiedImage.classifiers.first?.classes.first?.classification {
                    DispatchQueue.main.async {
                         self.navigationItem.title = classification
                        button.isEnabled = true
                    }
                }
                
                
            }else{
                DispatchQueue.main.async {
                    self.navigationItem.title = "Could not be determined"
                    button.isEnabled = true
                }
            }
            
            
        }
        
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

