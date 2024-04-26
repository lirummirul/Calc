//
//  Model.swift
//  calc
//
//  Created by Lambert Lani on 4/26/24.
//

import UIKit

enum OperationType: String {
    case plus = "+"
    case minus = "-"
    case division = "/"
    case multi = "*"
    case equal = "="
}

class CalculatorModel {
    private var leftOperand: Int?
    private var operation: OperationType?

    func buttonClick(_ buttonText: String) {
        var text = ""

        if let displayLabelText = ViewController.displayLabel.text {
            text = displayLabelText
        }

        text += buttonText
        ViewController.displayLabel.text = text
        
   
        performOperation(buttonText)
    }

    func performOperation(_ operationText: String) {
        guard let operation = OperationType(rawValue: operationText) else {
            return
        }

        
        if case .equal = operation,
            let existingOperation = self.operation,
            let leftOperand = leftOperand,
            let rightOperandText = ViewController.displayLabel.text,
            let rightOperand = Int(rightOperandText) {
            performOperation(existingOperation, lft: leftOperand, rgt: rightOperand)
        }

//        print(operation == .equal)
//        print(self.operation)
//        print(leftOperand)
//        print(ViewController.displayLabel.text)
        
        guard let leftOperandText = ViewController.displayLabel.text,
            let leftOperand = Int(leftOperandText) else {
                return
        }

        self.leftOperand = leftOperand
        self.operation = operation
        ViewController.displayLabel.text = nil
    }

    private func performOperation(_ operation: OperationType, lft: Int, rgt: Int) {
        var result: Int = 0

        switch operation {
        case .plus:
            result = lft + rgt

        case .minus:
            result = lft - rgt

        case .division:
            result = lft / rgt

        case .multi:
            result = lft * rgt

        default:
            break
        }

        ViewController.displayLabel.text = String(result)
    }
}
