//
//  SemiCirclularProgressView.swift
//  CustomDialProgressBar
//
//  Created by Avinash Thakur on 19/01/23.
//

import SwiftUI

struct SemiCircularProgressBar: View {
    @Binding var progress: Float
    @Binding var baseColor: Color
    @Binding var fillColor: Color
    @Binding var progressDotColor: Color
    @Binding var diameter: CGFloat
    @Binding var arcWidth: CGFloat
    
    @State var initialPointA = 0.5
    
    @State var modifiedProgress = 0.0

    let arcLength = 0.06
    let arcSpace = 0.02
    
    private var rotationAngle: Angle {
        return Angle(degrees: (360.0 * Double((progress) / 2)))
       }
    
    var body: some View {
        ZStack {
            // started the base semicircle with 0.02 spacing and ended with same to have equal arcs with size - 0.06 & space 0.02
//            Circle()
//                .trim(from: 0.52, to: 0.98)
//                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
//                .foregroundColor(baseColor)
//                .rotationEffect(Angle(degrees: 360))
            
            //Step1: Draws 6 base circular arcs of equal parts
            SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: fillColor.opacity(0.4), arcWidth: arcWidth)
            SemiCircleArc(startPoint: 0.60, endPoint: 0.66, arcColor: fillColor.opacity(0.4), arcWidth: arcWidth)
            SemiCircleArc(startPoint: 0.68, endPoint: 0.74, arcColor: fillColor.opacity(0.4), arcWidth: arcWidth)
            SemiCircleArc(startPoint: 0.76, endPoint: 0.82, arcColor: fillColor.opacity(0.4), arcWidth: arcWidth)
            SemiCircleArc(startPoint: 0.84, endPoint: 0.90, arcColor: fillColor.opacity(0.4), arcWidth: arcWidth)
            SemiCircleArc(startPoint: 0.92, endPoint: 0.98, arcColor: fillColor.opacity(0.4), arcWidth: arcWidth)
            let cgFloatProgress = CGFloat(progress)
    

            if progress > 0.0 && progress <= 0.166 {
                SemiCircleArc(startPoint: 0.52, endPoint: min((cgFloatProgress/2) + 0.5, 0.58), arcColor: fillColor, arcWidth: arcWidth)
            } else if progress > 0.166 && progress <= 0.332 {
                SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.60, endPoint: min((cgFloatProgress/2) + 0.5, 0.66), arcColor: fillColor, arcWidth:  arcWidth)
               // modifiedProgress = (cgFloatProgress/2) + 0.52
            } else if progress > 0.332 && progress <= 0.5 {
                SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.60, endPoint: 0.66, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.68, endPoint:min((cgFloatProgress/2) + 0.5, 0.74), arcColor: fillColor, arcWidth: arcWidth)
            } else if progress > 0.5 && progress <= 0.664 {
                SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.60, endPoint: 0.66, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.68, endPoint: 0.74, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.76, endPoint: min((cgFloatProgress/2) + 0.5, 0.82), arcColor: fillColor, arcWidth: arcWidth)
            } else if progress > 0.664 && progress <= 0.83 {
                SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.60, endPoint: 0.66, arcColor: fillColor, arcWidth:  arcWidth)
                SemiCircleArc(startPoint: 0.68, endPoint: 0.74, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.76, endPoint: 0.82, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.84, endPoint: min((cgFloatProgress/2) + 0.5, 0.90), arcColor: fillColor, arcWidth: arcWidth)
            } else if progress > 0.83 && progress <= 1.0 {
                SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.60, endPoint: 0.66, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.68, endPoint: 0.74, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.76, endPoint: 0.82, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.84, endPoint: 0.90, arcColor: fillColor, arcWidth: arcWidth)
                SemiCircleArc(startPoint: 0.92, endPoint: min((cgFloatProgress/2) + 0.5, 0.98), arcColor: fillColor, arcWidth: arcWidth)
            }
            
            
            // Step2: Added offset value of radius of circle so that the progress falls on semi circle
            ProgressDot(baseColor: $baseColor, fillColor: $fillColor)
                .offset(y: -(diameter / 2))
                .rotationEffect(Angle(degrees: 270.0)) // angle to move dot from left to right
                .rotationEffect(rotationAngle)
            
            Text(String(format: "%.0f %%", min(cgFloatProgress, 1.0)*100.0))
                .font(.title)
                .bold()
                .offset(y: -50)
        }
    }
    
}



// Semi Circle arc for semi circle progress bar with no rotation angle
struct SemiCircleArc: View {
    @State var startPoint: CGFloat
    @State var endPoint: CGFloat
    @State var arcColor: Color
    @State var arcWidth: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: startPoint, to: endPoint)
            .stroke(style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(arcColor)
    }
}

struct ProgressDot: View {
    @Binding var baseColor: Color
    @Binding var fillColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 28, height: 28)
            Circle()
                .fill(fillColor)
                .frame(width: 10, height: 10)
        }
    }
}
