//
//  ContentView.swift
//  CustomDialProgressBar
//
//  Created by Avinash Thakur on 12/01/23.
//

import SwiftUI

struct ContentView: View {
    @State var progressValue: Float = 0.16
    @State var circleColor: Color = .gray
    @State var circleFillColor: Color = .green
    @State var progressDotColor: Color = .yellow
    @State var arcWidth: CGFloat = 15.0
    @State var diameter: CGFloat = 300.0 // diameter of circle i.e containing subview can be of width: 300, height = 150
    
    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)
        }
        
        VStack {
            SemiCircularProgressBar(progress: self.$progressValue, baseColor: self.$circleColor, fillColor: self.$circleFillColor, progressDotColor: self.$progressDotColor, diameter: $diameter, arcWidth: $arcWidth)
                .frame(width: diameter, height: diameter)

            // added offset as the above Semi circle takes full circle space while drawing.
            
            Button("Post") {
                NotificationCenter.default.post(name: Notification.Name("onScoreUpdated"), object: nil, userInfo: nil)
            }
            .frame(width: 100, height: 50)
            .font(.title)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            CircularProgressBar(progress: self.progressValue, baseColor: self.circleColor, fillColor: self.circleFillColor, arcWidth: arcWidth)
                .frame(width: 150, height: 150)
                .padding(20.0)
           //     .offset(y: -150)
            
            
            
        }
    }
    
}

func getMappedProgress() {
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
