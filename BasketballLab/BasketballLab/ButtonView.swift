//
//  ButtonView.swift
//  AIBasketballTrainer
//
//  Created by Onik Hoque on 2/17/24.
//

import SwiftUI

struct ButtonView: View {
    
    var text : String
    var imageName : String
    var widthProportion : Double
  
    
    var body: some View {
        HStack {
            Text(text)
            Image(systemName: imageName)
        }.frame(width: widthProportion*UIScreen.main.bounds.width,
                height: 40)
      

    }
}

#Preview {
    ButtonView(text: "Play", imageName: "basketball", widthProportion: 3/4)
}
