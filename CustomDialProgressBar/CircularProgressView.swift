//
//  CircularProgressView.swift
//  CustomDialProgressBar
//
//  Created by Avinash Thakur on 19/01/23.
//

import SwiftUI

extension NSNotification.Name {
    static let onScoreUpdated = Notification.Name("onScoreUpdated")
}

struct CustomView: View {
    @State var progress: Float
    
    var body: some View {
        ZStack {
            CircularProgressBar(progress: progress, baseColor: Color.yellow, fillColor: Color.yellow, arcWidth: 10.0)
        }
        .onReceive(NotificationCenter.default.publisher(for: .onScoreUpdated), perform: { _ in
            progress = 0.90
                })
    }
}


struct CircularProgressBar: View {
    @State var progress: Float
    @State var baseColor: Color
    @State var fillColor: Color
    @State var arcWidth: CGFloat
    
    var body: some View {
        ZStack {
            // Step1: Draws 3 base circular arcs of equal parts of size 0.27 and having space 0.06
            CircleArc(startPoint: 0.0, endPoint: 0.27, arcColor: baseColor, arcWidth: arcWidth)
            CircleArc(startPoint: 0.33, endPoint: 0.59, arcColor: baseColor, arcWidth: arcWidth)
            CircleArc(startPoint: 0.65, endPoint: 0.94, arcColor: baseColor, arcWidth: arcWidth)
            
            let floatProgress = CGFloat(progress)
            
            //Step 2: Draws circular arcs as per progress value
            if floatProgress > 0.0 && floatProgress < 0.3 {
                // Draws 1st arc full or as per progress
                CircleArc(startPoint: 0.0, endPoint: min(floatProgress, 0.27), arcColor: fillColor, arcWidth: arcWidth)
            } else if floatProgress > 0.3 && floatProgress < 0.6 {
                // Draws 1st arc full
                CircleArc(startPoint: 0.0, endPoint: 0.27, arcColor: fillColor, arcWidth: arcWidth)
                // Draws 2nd arc  full or as per progress
                CircleArc(startPoint: 0.33, endPoint: min(floatProgress, 0.59), arcColor: fillColor, arcWidth: arcWidth)
            } else if floatProgress > 0.6 {
                // Draws 1st arc full
                CircleArc(startPoint: 0.0, endPoint: 0.27, arcColor: fillColor, arcWidth: arcWidth)
                // Draws 2nd arc full
                CircleArc(startPoint: 0.33, endPoint: 0.59, arcColor: fillColor, arcWidth: arcWidth)
                // Draws 3rd arc full or as per progress
                CircleArc(startPoint: 0.65, endPoint: min(floatProgress, 0.94), arcColor: fillColor, arcWidth: arcWidth)
            }
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.title)
                .bold()
            
        }
    }
}

// Circle arc for full circular progress bar with rotation angle of 270
struct CircleArc: View {
    @State var startPoint: CGFloat
    @State var endPoint: CGFloat
    @State var arcColor: Color
    @State var arcWidth: CGFloat
    
    var body: some View {
       
        Circle()
            .trim(from: startPoint, to: endPoint)
            .stroke(style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(arcColor)
                .rotationEffect(Angle(degrees: 270.0))
    }
}
