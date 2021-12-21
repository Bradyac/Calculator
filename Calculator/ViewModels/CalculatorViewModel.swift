//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-29.
//

import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    @Published var allClear: String = "AC"
    private var lastButtonPressed: CalculatorButton = .none
    private var currentOperation: CalculatorButton = .none
    private var firstNumber: Double? = nil
    private var secondNumber: Double? = nil
    private var isTyping: Bool = false
    private var equalsPressed: Bool = false
    
    // retrieve the button that was last pressed and perform the required operation to alter the state of the view model
    func receiveInput(calculatorButton: CalculatorButton) {
            switch calculatorButton {
                case .negate:
                    self.isTyping = true
                    var negatedValue: Double
                    if currentOperation == lastButtonPressed {
                        self.display = "-0"
                    } else {
                        negatedValue = -(Double(self.display.withoutCommas())!)
                        if secondNumber != nil && equalsPressed {
                            firstNumber = negatedValue
                        } else if (secondNumber != nil) {
                            secondNumber = negatedValue
                        }
                        formatAndSetDisplayValue(value: negatedValue)
                    }
                case .percent:
                    var percent: Double = Double(self.display.withoutCommas())! / 100
                    if (currentOperation == .add || currentOperation == .subtract) && !equalsPressed {
                        if secondNumber == nil {
                            percent = firstNumber! * (firstNumber!/100)
                        } else {
                            percent = firstNumber! * (secondNumber!/100)
                        }
                    } else if equalsPressed {
                        firstNumber = secondNumber
                        secondNumber = Double(self.display.withoutCommas())!
                    }
                    secondNumber = percent
                    formatAndSetDisplayValue(value: percent)
                case .dot:
                    self.isTyping = true
                    switch self.lastButtonPressed {
                    case .add, .subtract, .multiply, .divide, .equals:
                        self.display = "0."
                    default:
                        if !self.display.contains(".") && self.display.withoutCommas().count < 9 {
                            self.display += "."
                        }
                    }
                    self.allClear = "C"
                case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
                    if !self.isTyping || self.display == "0" {
                        self.display = calculatorButton.rawValue
                        self.isTyping = true
                    } else {
                        if self.display.withoutCommas().count < 9 || (self.display.withoutCommas().count < 10 && self.display.contains(".")) {
                            self.display += calculatorButton.rawValue
                            if !self.display.contains(".") {
                                self.display = (Double(self.display.withoutCommas())?.withCommas())!
                            }
                            self.isTyping = true
                        }
                    }
                    if self.currentOperation != .none {
                        self.secondNumber = Double(self.display.withoutCommas())
                    }
                    if calculatorButton != .zero { self.allClear = "C" }
                case .add, .subtract, .multiply, .divide:
                    self.isTyping = false
                    if self.firstNumber != nil && self.secondNumber != nil && !self.equalsPressed && self.lastButtonPressed != currentOperation {
                        self.firstNumber = performOperation(x: self.firstNumber!, y: self.secondNumber!, operation: self.currentOperation)
                        formatAndSetDisplayValue(value: firstNumber!)
                    } else {
                        self.firstNumber = Double(self.display.withoutCommas())
                        self.equalsPressed = false
                    }
                    self.currentOperation = calculatorButton
                case .equals:
                    if firstNumber != nil {
                        self.isTyping = false
                        self.equalsPressed = true
                        if secondNumber == nil {
                            let total = performOperation(x: Double(self.display.withoutCommas())!, y: self.firstNumber!, operation: currentOperation)
                            formatAndSetDisplayValue(value: total)
                        } else {
                            self.firstNumber = performOperation(x: self.firstNumber!, y: self.secondNumber!, operation: currentOperation)
                            formatAndSetDisplayValue(value: self.firstNumber!)
                        }
                    }
                case .clear:
                    self.allClear = "AC"
                    self.display = "0"
                    self.firstNumber = nil
                    self.secondNumber = nil
                    self.currentOperation = .none
                    self.equalsPressed = false
                default:
                    self.display = "Error"
            }
        self.lastButtonPressed = calculatorButton
    }
    
    // converts a double value to a formatted string which is then set as the display value
    private func formatAndSetDisplayValue(value: Double) {
        // if the value is beyond the maximum or minimum value allowed throw an error to the display
        // else if the value is very large/small display the value in scientific notation
        // else display the value with commas
        if value > 1e160 || value < -9E160 {
            self.display = "Error"
            self.firstNumber = nil
            self.secondNumber = nil
        } else if value != 0 && (value > 999999999 || value < -999999999 || abs(value) < 9E-9) {
            self.display = value.inSciNotation()
        } else {
            self.display = value.withCommas()
        }
    }
    
    // performs a basic math operation and returns the result
    private func performOperation(x: Double, y: Double, operation: CalculatorButton) -> Double {
        switch operation {
            case .add: return x + y
            case .subtract: return x - y
            case .multiply: return x * y
            case .divide: return x / y
            default: return 0
        }
    }
}
