//
//  ContentView.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-26.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var flags = Array(repeating: false, count: 4)
    let btns:[[CalculatorButton]] = [
        [.clear, .negate, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .dot, .equals]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if colorScheme == .dark {
                Color.darkEnd.edgesIgnoringSafeArea(.all)
            } else {
                Color.offWhite.edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 12) {
                DisplayView(scheme: colorScheme)
                ForEach(btns, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            switch button.rawValue {
                            case "+", "-", "x", "÷": CalculatorToggleButtonView(storage: self.$flags, tag: button.rawValue, colourScheme: colorScheme, button: button)
                            default: CalculatorButtonsView(storage: self.$flags, colourScheme: colorScheme, button: button)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
            .environmentObject(CalculatorViewModel())
    }
}
