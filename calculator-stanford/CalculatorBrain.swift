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
    
    // enum to case for constant, unary, binary, or equal ... your OPERATIONS
    private enum Operation {
        // associated value
        case constant(Double)
        // function that takes a Double and returns a Double
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary <String,Operation> =
        [
            // constant values
            "pi" : Operation.constant(Double.pi), // Double.pi,
            "e" : Operation.constant(M_E), // M_E,
            // single operations
            "√" : Operation.unaryOperation(sqrt),
            "cos" : Operation.unaryOperation(cos),
            "±" : Operation.unaryOperation({ -$0 }),
            // two constant operations
            "✖️" : Operation.binaryOperation({ $0 * $1 }),
            "➗" : Operation.binaryOperation({ $0 / $1 }),
            "➖" : Operation.binaryOperation({ $0 - $1 }),
            "➕" : Operation.binaryOperation({ $0 + $1 }),
            "=" : Operation.equals
            //"+" : Operation.unaryOperation,
    ]
    
    /* Public
     */
    
    mutating func performOperation(_ symbol: String) {
        // if symbol exists in operations dictionary, let constant = it
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                
            }
        }
        
    }
    
    private mutating func performPendingBinaryOperation() {
        // optional, if not set will ignore line (when using ? instead of !)
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        // swift like internal syntax, self documenting
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
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




// NOT NEEDED DUE TO CLOSURE
func changeSign(operand: Double) -> Double {
    return -operand
}

// NOT NEEDED DUE TO CLOSURES
func multiply(op1: Double, op2: Double) -> Double{
    return op1 * op2
}

// Optionals are enums with two values
// Closures are super cool, dial inline to essentials of simple functions
// Closures can pass code to methods on when: fail, completion, do this and animate it, etc.
// Pass methods around - powerful
