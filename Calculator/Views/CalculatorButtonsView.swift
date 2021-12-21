//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-29.
//

import SwiftUI

struct CalculatorButtonsView: View {
    @EnvironmentObject var env: CalculatorViewModel
    @Binding var storage: [Bool]
    var colourScheme: ColorScheme
    var button: CalculatorButton
    
    var body: some View {
        // when a regular calculator button is pressed
        Button(action: {
            self.env.receiveInput(calculatorButton: button) // send the input to the view model
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred() // provide haptic feedback
            
            // sets all toggle style buttons to untoggled
            switch button {
                case .clear, .equals, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
                    withAnimation {
                        for i in 0...3  {
                            storage[i] = false
                        }
                    }
                default: break
            }
        }) {
            switch button {
                case .zero:
                    CustomText(label: button.rawValue)
                        .padding(.trailing, 90)
                        .frame(
                            width: (UIScreen.main.bounds.width - 4 * 8.5) / 4 * 2,
                            height: (UIScreen.main.bounds.width - 5 * 12) / 4
                        )
                case .clear:
                    CustomText(label: env.allClear)
                default:
                    CustomText(label: button.rawValue)
            }
        }
        .buttonStyle(CalculatorButtonStyle(label: button.rawValue, scheme: colourScheme))
    }
    
    func CustomText(label: String) -> some View {
        let buttonDimension: CGFloat = (UIScreen.main.bounds.width - 5 * 12) / 4
        return Text(label)
            .fontWeight(.light)
            .opacity(0.7)
            .frame(width: buttonDimension, height: buttonDimension)
    }
}
