//
//  CalculatorBrain.swift
//  calculator-stanford
//
//  Created by DE on 5/22/17.
//  Copyright © 2017 DE. All rights reserved.
//

import Foundation

// MODEL

// Public API of model
struct CalculatorBrain {
    

    // internal, only accessed by this struct
    private var accumulator: Double?
    
    /* Public
    */
    
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "sq":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        default:
            break
        }
    }
    
    // changes value of the struct, must set 'mutating'
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    // read only computed property, get only
    // result is optional
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
