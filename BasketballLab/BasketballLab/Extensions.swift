//
//  Extensions.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import Foundation
import SwiftUI

//allows usage of if for view modifiers on views
extension View {
    /// Applies the given transform if the given condition evaluates to true.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source View.
    /// - Returns: Either the original View or the modified View if the condition is true.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


//allows for locking of a view in portrait mode. in my case, the camera. 
/*
struct LandscapeFullScreenCover<CoverContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let coverContent: () -> CoverContent
    @State private var supportedOrientations: UIInterfaceOrientationMask = .portrait

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                coverContent()
            }
            .onChange(of: isPresented, perform: { supportedOrientations = $0 ? .landscape : .portrait })
            .supportedOrientations(supportedOrientations)
    }
}

extension View {
    func landscapeFullScreenCover(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> some View) -> some View {
        modifier(LandscapeFullScreenCover(isPresented: isPresented, coverContent: content))
    }
}
*/
