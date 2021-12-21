//
//  File.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-29.
//

import UIKit
import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    var label: String
    var scheme: ColorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .contentShape(Circle())
            .background(
                Group {
                    switch label {
                    case "0":
                        let width: CGFloat = (UIScreen.main.bounds.width - 4 * 8.5) / 4 * 2
                        if scheme == .dark {
                            DarkBackground(isPressed: configuration.isPressed, shape: RoundedRectangle(cornerRadius: 40), width: width)
                        } else {
                            LightBackground(isPressed: configuration.isPressed, shape: RoundedRectangle(cornerRadius: 40), width: width)
                        }
                    default:
                        let width: CGFloat = (UIScreen.main.bounds.width - 5 * 12) / 4
                        if scheme == .dark {
                            DarkBackground(isPressed: configuration.isPressed, shape: Circle(), width: width)
                        } else {
                            LightBackground(isPressed: configuration.isPressed, shape: Circle(), width: width)
                        }
                    }
                }
            )
    }
}

struct CalcuatorToggleButtonStyle: ToggleStyle {
    @EnvironmentObject var env: CalculatorViewModel
    var scheme: ColorScheme
    var button: CalculatorButton
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
            self.env.receiveInput(calculatorButton: button)
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }) {
            configuration.label
                .font(.largeTitle)
                .contentShape(Circle())
                .background(
                    Group {
                        let width: CGFloat = (UIScreen.main.bounds.width - 5 * 12) / 4
                        if scheme == .dark {
                            DarkBackground(isPressed: configuration.isOn, shape: Circle(), width: width)
                        } else {
                            LightBackground(isPressed: configuration.isOn, shape: Circle(), width: width)
                        }
                    }
                    
                )
        }
    }
}

struct UIKitShadowView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    var width: CGFloat
    
    func makeUIView(context: Context) -> UIView {
        return UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: (UIScreen.main.bounds.width - 5 * 12) / 4
            )
        )
        .addShadow(scheme: colorScheme)
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct DarkBackground<S: Shape>: View {
    var isPressed: Bool
    var shape: S
    var width: CGFloat
    
    var body: some View {
        ZStack {
            if isPressed {
                shape
                    .fill(Color.darkEnd)
                    .overlay(
                        shape
                            .stroke(Color.black, lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: 1.5, y: 1.5)
                            .mask(
                                shape
                                    .fill(LinearGradient(Color.black.opacity(0.7), Color.clear))
                            )
                    )
                    .overlay (
                        shape
                            .stroke(Color.gray, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: -1.5, y: -1.5)
                            .mask(
                                shape
                                    .fill(LinearGradient(Color.clear, Color.black.opacity(0.3)))
                        )
                    )

            } else {
                UIKitShadowView(width: width)
                    .overlay(
                        shape
                            .fill(Color.darkEnd)
                            .overlay(
                                shape
                                    .stroke(Color.gray, lineWidth: 1)
                                    .blur(radius: 1.5)
                                    .opacity(0.25)
                                    .mask(
                                        shape
                                            .fill(LinearGradient(.gray, .clear))
                                    )
                            )
                            .shadow(color: Color.black.opacity(0.4), radius: 6, x: 5, y: 5)
                    )
            }
        }
    }
}

struct LightBackground<S: Shape>: View {
    var isPressed: Bool
    var shape: S
    var width: CGFloat
    
    var body: some View {
        ZStack {
            if isPressed {
                shape
                    .fill(Color.offWhite)
                    .overlay(
                        shape
                            .stroke(Color.gray, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 1.5, y: 1.5)
                            .mask(
                                shape
                                    .fill(LinearGradient(Color.black, Color.clear))
                            )
                    )
                    .overlay (
                        shape
                            .stroke(Color.offWhite, lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -1.5, y: -1.5)
                            .mask(
                                shape
                                    .fill(LinearGradient(Color.clear, Color.black))
                        )
                    )
            } else {
                UIKitShadowView(width: width)
                    .overlay(
                        shape
                            .fill(Color.offWhite)
                            .overlay(
                                shape
                                    .stroke(Color.gray, lineWidth: 1.5)
                                    .blur(radius: 1.5)
                                    .opacity(0.5)
                                    .mask(
                                        shape
                                            .fill(LinearGradient(.gray, .clear))
                                    )
                            )
                            .shadow(color: Color.gray.opacity(0.4), radius: 6, x: 5, y: 5)
                    )
            }
        }
    }
}
