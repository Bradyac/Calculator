//
//  CalculatorToggleButtonView.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-11-10.
//

import SwiftUI

struct CalculatorToggleButtonView: View {
    @EnvironmentObject var env: CalculatorViewModel
    @Binding var storage: [Bool]
    var tag: String
    var colourScheme: ColorScheme
    var button: CalculatorButton
    
    var body: some View {
        let t: Int = self.tag == "+" ? 0 : self.tag == "-" ? 1 : self.tag == "x" ? 2 : 3
        let isOn = Binding (
            get: { self.storage[t] },
            set: { value in
                withAnimation {
                    self.storage = self.storage.enumerated().map { $0.0 == t }
                }
            }
        )
        Toggle(isOn: isOn) {
            CustomText(label: button.rawValue)
        }
        .toggleStyle(CalcuatorToggleButtonStyle(scheme: colourScheme, button: button))
    }
    
    func CustomText(label: String) -> some View {
        let buttonDimension: CGFloat = (UIScreen.main.bounds.width - 5 * 12) / 4
        return Text(label)
            .fontWeight(.light)
            .foregroundColor(colourScheme == .dark ? Color.white : Color.black)
            .opacity(0.7)
            .frame(width: buttonDimension, height: buttonDimension)
    }
}
