//
//  ViewController.swift
//  calculator-stanford
//
//  Created by DE on 5/13/17.
//  Copyright © 2017 DE. All rights reserved.
//

import UIKit

// CONTROLLER

// Class of inheritance: UIViewController
// Swift is single inheritance
// Swift: properties & methods
// Swift: all properties must be initialized
class ViewController: UIViewController {
    
    //
    @IBOutlet weak var display: UILabel!
    var userIsTyping = false
    
    
    
    //
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textCurrentlyInDisplay = display!.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    // Computed properties
    var displayValue: Double {
        get {
            return Double(display.text!)!
            
        }
        set {
            display.text = String(newValue)
        }
    }
    
    // model to show is created from struct
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        
        //
        if let result = brain.result {
            displayValue = result
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// Optional has two values: set and not set
// When set it has an 'associated value'
// String? = an Optional with an associated value of type 'String'

// external - internal names
// external names picked to read like English
// _ = no external name
//func drawHorizontalLine(from startX: Double, to endX: Double, using color: UIColor){
//
//
//
//}
