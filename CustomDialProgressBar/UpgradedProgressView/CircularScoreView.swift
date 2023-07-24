//
//  CircularScoreView.swift
//  SafeHouse
//
//  Created by Avinash Thakur on 19/01/23.
//  Copyright © 2023 Safehouse Technologies. All rights reserved.
//

import Combine
import SwiftUI

// MARK: - CustomScoreView

struct CustomScoreView: View {
  // MARK: Internal

  @State
  var score: Int
  @State
  var frame: Double
  @State
  var fillColor: Color
  @State
  var progress: Float = 0
  @State
  var progressString: String = ""
  @State
  var arcValue: Double = 10.0
  @State
  var baseColor: Color = .gray

  var body: some View {
    ZStack {
      CircularScoreView(
        progress: $progress,
        baseColor: $baseColor,
        fillColor: $fillColor,
        arcWidth: 10,
        progressString: $progressString,
        arcEndValue: $arcValue
      )
      .frame(width: frame, height: frame)
    }
//    .onReceive(
//      NotificationCenter.default.publisher(for: .onSafetyScoreUpdate),
//      perform: { notification in
//        guard let userInfo = notification.userInfo, let scoreVal = userInfo["progress"] as? Int,
//              let color = userInfo["color"] as? UIColor else {
//          return
//        }
//        fillColor = Color(color)
//        score = scoreVal
//        progress = progressInFloat
//        progressString = progressInStr
//        arcValue = progressEndValue
 //     }
 //   )
  }

  // MARK: Private

  /// Variable stores the end point value calculated from given progress input,which is passed as end point for drawing the progress arc. Min value is returned as the arc remains within the respective arc out of  3 equally divided arcs.
  private var progressEndValue: Double {
    if progress <= 0.33 {
      return min(Double(progress), 0.29)
    } else if progress > 0.33, progress <= 0.66 {
      return min(Double(progress), 0.62)
    } else if progress > 0.66 {
      return min(Double(progress), 0.96)
    } else {
      return Double(progress)
    }
  }

  /// Variable to convert progress received in Int to Float by dividing using max safety score.
  private var progressInFloat: Float {
    Float(score) / Float(100)
  }

  /// Variable to convert progress received in Int to String.
  private var progressInStr: String {
    String(score)
  }
}

// MARK: - CircularScoreView

struct CircularScoreView: View {
  @Binding
  var progress: Float
  @Binding
  var baseColor: Color
  @Binding
  var fillColor: Color
  @State
  var arcWidth: CGFloat
  @Binding
  var progressString: String
  @Binding
  var arcEndValue: Double

  var body: some View {
    ZStack {
      // Step 2: Draws 3 base circular arcs
        CircleArc(startPoint: 0.00, endPoint: 0.29, arcColor: baseColor, arcWidth: arcWidth)
        .opacity(0.2)
      CircleArc(startPoint: 0.33, endPoint: 0.62, arcColor: baseColor, arcWidth: arcWidth)
        .opacity(0.2)
      CircleArc(startPoint: 0.66, endPoint: 0.96, arcColor: baseColor, arcWidth: arcWidth)
        .opacity(0.2)

      // Step 2: Draws circular arcs as per progress value
      if progress <= 0.33 {
        // Draws 1st arc full or as per progress
        CircleArcFill(
          startPoint: 0.0,
          endPoint: $arcEndValue,
          arcColor: $fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.33, progress <= 0.66 {
        // Draws 1st arc full$

        CircleArc(startPoint: 0.0, endPoint: 0.29, arcColor: fillColor, arcWidth: arcWidth)
        // Draws 2nd arc  full or as per progress
        CircleArcFill(
          startPoint: 0.33,
          endPoint: $arcEndValue,
          arcColor: $fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.66 {
        // Draws 1st arc full
        CircleArc(startPoint: 0.0, endPoint: 0.29, arcColor: fillColor, arcWidth: arcWidth)
        // Draws 2nd arc full
        CircleArc(
          startPoint: 0.33,
          endPoint: 0.62,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        // Draws 3rd arc full or as per progress
        CircleArcFill(
          startPoint: 0.66,
          endPoint: $arcEndValue,
          arcColor: $fillColor,
          arcWidth: arcWidth
        )
      }

      Text(progressString)
            .foregroundColor(.black)
      //  .font(Font(vm.setBoldFontWithSize(size: 32)))
    }
  }
}

// MARK: - CircleArc

/// Circle arc for full circular progress bar with rotation angle of 270 + 10 degree tilt so have the circle axis in center.
struct CircleArc: View {
  @State
  var startPoint: Double
  @State
  var endPoint: Double
  @Binding
  var arcColor: Color
  @State
  var arcWidth: CGFloat

  var body: some View {
    Circle()
      .trim(from: startPoint, to: endPoint)
      .stroke(style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .round))
      .foregroundColor(arcColor)
      .rotationEffect(Angle(degrees: 280.0))
  }
}

// MARK: - CircleArcFill

/// Circle arc for filling the progress with rotation angle of 270 + 10 degree tilt so have the circle axis in center.
struct CircleArcFill: View {
  @State
  var startPoint: Double
  @Binding
  var endPoint: Double
  @Binding
  var arcColor: Color
  @State
  var arcWidth: CGFloat

  var body: some View {
    Circle()
      .trim(from: startPoint, to: endPoint)
      .stroke(style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .round))
      .foregroundColor(arcColor)
      .rotationEffect(Angle(degrees: 280.0))
  }
}
