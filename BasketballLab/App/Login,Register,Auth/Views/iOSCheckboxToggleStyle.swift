//
//  iOSCheckboxToggleStyle.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/3/24.
//

import Foundation
import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {

            // 2
            configuration.isOn.toggle()

        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.square" : "square").foregroundColor(Color.black)

                configuration.label
            }
        })
    }
}
