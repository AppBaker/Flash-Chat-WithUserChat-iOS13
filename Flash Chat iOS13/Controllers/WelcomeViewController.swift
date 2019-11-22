//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel
import FirebaseAuth

class WelcomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleLabel.charInterval = 1
        titleLabel.text = K.appName
        
//        titleLabel.text = ""
//        var charIndex = 0.0
//        let titleText = "⚡️FlashChat_"
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: charIndex * 0.5, repeats: false) { (timer) in
//                self.titleLabel.text?.append(letter)
//                print("-\(letter)-")
//
//                if self.titleLabel.text?.last == "_" {
//                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
//                        if self.titleLabel.text?.last == "_" {
//                            self.titleLabel.text?.removeLast()
//                            self.titleLabel.text?.append(" ")
//
//                        } else if self.titleLabel.text?.last == " " {
//                            self.titleLabel.text?.removeLast()
//                            self.titleLabel.text?.append("_")
//
//                        }
//                    }
//                }
//            }
//            charIndex += 1
//            print(charIndex)
//
//        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
}
