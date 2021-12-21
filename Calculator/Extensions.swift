//
//  Extensions.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-29.
//

import SwiftUI
import UIKit

extension Color {
    //static let offWhite = Color(red: 215 / 255, green: 215 / 255, blue: 235 / 255)
    static let offWhite = Color(red: 225 / 255, green: 235 / 255, blue: 240 / 255)
    static let darkStart = Color(red: 50 / 255, green: 55 / 255, blue: 60 / 255)
    static let darkEnd = Color(red: 40 / 255, green: 40 / 255, blue: 42 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 8
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
    func inSciNotation() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 5
        numberFormatter.numberStyle = .scientific
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension String {
    func withoutCommas() -> String {
        return self.replacingOccurrences(of: ",", with: "")
    }
}

extension UIView {
    func addShadow(scheme: ColorScheme) -> UIView {
        self.layer.cornerRadius = 40
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = scheme == ColorScheme.dark ? Color.darkStart.cgColor : UIColor.white.cgColor
        shadowLayer.shadowOffset = CGSize(width: -1.5, height: -1.5)
        shadowLayer.shadowOpacity = scheme == ColorScheme.dark ? 0.7 : 1
        shadowLayer.shadowRadius = 5
        self.layer.insertSublayer(shadowLayer, at: 0)
        
        return self
    }
}
