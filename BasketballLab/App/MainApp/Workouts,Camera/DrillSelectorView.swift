//
//  DrillSelectorView.swift
//  BasketballLab
//
//  Created by Onik Hoque on 3/7/24.
//

import SwiftUI

struct DrillSelectorView: View {
    
    var title : String
    var description : String
    //var imageName : String
    
    var body: some View {
        

        
        ZStack {
            Image(systemName: "figure.basketball").resizable().padding().scaledToFit()
            VStack {
                HStack {
                    Text(title).font(.title2).padding().foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").padding()
                }//.frame(width: 200, height: 200).background(Color.red)
                Spacer()
                Text(description).padding().font(.caption).foregroundColor(.black)
            }
        }.frame(width: 250, height: 250).background(Color.red).cornerRadius(10).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 1)).padding()
    }
}

#Preview {
    DrillSelectorView(title: "Dribble Counter", description: "Count your dribbles across a training session to gauge workout intensity.")
}
