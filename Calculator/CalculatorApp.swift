//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-26.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(CalculatorViewModel())
        }
    }
}
