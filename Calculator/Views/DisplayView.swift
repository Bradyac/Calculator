//
//  DisplayView.swift
//  Calculator
//
//  Created by Brady Cunningham on 2020-10-29.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var env: CalculatorViewModel
    var scheme: ColorScheme
    
    var body: some View {
        HStack {
            Spacer()
            Text(env.display)
                .font(.system(size: 100))
                .fontWeight(.light)
                .foregroundColor(scheme == .dark ? Color.white : Color.black)
                .opacity(0.7)
                .lineLimit(1)
                .padding(.all)
                .frame(height: 100)
                .minimumScaleFactor(0.3)
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView(
            scheme: ColorScheme.light
        )
            .previewLayout(.sizeThatFits)
            .environmentObject(CalculatorViewModel())
    }
}
