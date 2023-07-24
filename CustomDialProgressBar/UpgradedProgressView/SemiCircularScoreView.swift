//
//  SemiCircularScoreView.swift
//  SafeHouse
//
//  Created by Avinash Thakur on 18/01/23.
//  Copyright © 2023 Safehouse Technologies. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - CustomSemiCircularScoreView

struct CustomSemiCircularScoreView: View {
  // MARK: Internal

  @State
  var progress: Float
  @State
  var baseColor: Color
  @State
  var fillColor: Color
  @State
  var progressDotColor: Color
  @State
  var diameter: CGFloat
  @State
  var arcWidth: CGFloat = 15.0
  @State
  var arcValue: Double = 0.0

  var body: some View {
    ZStack {
      SemiCircularScoreView(
        progress: $progress,
        baseColor: $baseColor,
        fillColor: $fillColor,
        progressDotColor: $progressDotColor,
        diameter: diameter,
        arcWidth: arcWidth,
        arcEndValue: $arcValue
      )
    }
    .onReceive(
      NotificationCenter.default.publisher(for: .onSafetyScoreUpdate),
      perform: { notification in
        guard let userInfo = notification.userInfo, let prog = userInfo["progress"] as? Float,
              let indicatorColor = userInfo["progressColor"] as? UIColor else {
          return
        }
        progress = prog
        progressDotColor = Color(indicatorColor)
        arcValue = progressEndValue
      }
    )
  }

  // MARK: Private

  /// Variable stores the end point value calculated from given progress input,which is passed as end point for drawing the progress arc. The value is calculated considering half of actual progress as we using semi circle plot which ranges from 0.5 - 1. Min value is returned as the arc remains within the respective arc out of  6 equally divided arcs.
  private var progressEndValue: Double {
    if progress > 0.0, progress <= 0.166 {
      return min(Double((progress / 2) + 0.5), 0.58)
    } else if progress > 0.166, progress <= 0.332 {
      return min(Double((progress / 2) + 0.5), 0.66)
    } else if progress > 0.332, progress <= 0.5 {
      return min(Double((progress / 2) + 0.5), 0.74)
    } else if progress > 0.5, progress <= 0.664 {
      return min(Double((progress / 2) + 0.5), 0.82)
    } else if progress > 0.664, progress <= 0.83 {
      return min(Double((progress / 2) + 0.5), 0.90)
    } else if progress > 0.83, progress <= 1.0 {
      return min(Double((progress / 2) + 0.5), 0.98)
    } else {
      return Double((progress / 2) + 0.5)
    }
  }
}

// MARK: - SemiCircularScoreView

/// Draws a semi circular progress UI divided into 6 equal parts. 6 equal base views are added then the actual progress is drawn by adding color filled arcs. The semi circle is drawn trimming arcs from 0.5 - 1.0 as we plot into the upper half part of circle. To keep it equally spaced, Arc of length - 0.06 & space - 0.02 are drawn. The progress dot is displayed by setting it's Y offset as -(diameter / 2) of circle with a rotational angle of 270 as per coordinate system.
struct SemiCircularScoreView: View {
  // MARK: Internal

  @Binding
  var progress: Float
  @Binding
  var baseColor: Color
  @Binding
  var fillColor: Color
  @Binding
  var progressDotColor: Color
  @State
  var diameter: CGFloat
  @State
  var arcWidth: CGFloat
  @Binding
  var arcEndValue: Double

  var body: some View {
    ZStack {
      // Step1: Draw base arcs
      drawBaseSemiCircleArcs(baseColor: baseColor, arcWidth: arcWidth)

      // Step2: Draws the filled circular arcs as per the progress value, First fills arc that is completely filled then draws arc with actual end value.
      if progress > 0.0, progress <= 0.166 {
        SemiCircleArcFill(
          startPoint: 0.52,
          endPoint: $arcEndValue,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.166, progress <= 0.332 {
        SemiCircleArc(
          startPoint: 0.52,
          endPoint: 0.58,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArcFill(
          startPoint: 0.60,
          endPoint: $arcEndValue,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.332, progress <= 0.5 {
        SemiCircleArc(
          startPoint: 0.52,
          endPoint: 0.58,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.60,
          endPoint: 0.66,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArcFill(
          startPoint: 0.68,
          endPoint: $arcEndValue,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.5, progress <= 0.664 {
        SemiCircleArc(
          startPoint: 0.52,
          endPoint: 0.58,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.60,
          endPoint: 0.66,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.68,
          endPoint: 0.74,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArcFill(
          startPoint: 0.76,
          endPoint: $arcEndValue,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.664, progress <= 0.83 {
        SemiCircleArc(
          startPoint: 0.52,
          endPoint: 0.58,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.60,
          endPoint: 0.66,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.68,
          endPoint: 0.74,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.76,
          endPoint: 0.82,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArcFill(
          startPoint: 0.84,
          endPoint: $arcEndValue,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
      } else if progress > 0.83, progress <= 1.0 {
        SemiCircleArc(
          startPoint: 0.52,
          endPoint: 0.58,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.60,
          endPoint: 0.66,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.68,
          endPoint: 0.74,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.76,
          endPoint: 0.82,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArc(
          startPoint: 0.84,
          endPoint: 0.90,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
        SemiCircleArcFill(
          startPoint: 0.92,
          endPoint: $arcEndValue,
          arcColor: fillColor,
          arcWidth: arcWidth
        )
      }

      // Step3: Added offset value of radius of circle so that the progress falls on semi circle
      ProgressDot(baseColor: .white, fillColor: $progressDotColor)
        .offset(y: SafeHouseData.isIphone() ? -(diameter / 2) : -((diameter - 12) / 4))
        .rotationEffect(Angle(degrees: 270.0)) // angle to move dot from left to right
        .rotationEffect(rotationAngle)
    }
  }

  // MARK: Private

  private var rotationAngle: Angle {
    Angle(degrees: 360.0 * min(Double(progress / 2), Double(0.98 / 2)))
  }
}

// max(Double((progress / 2), ((0.96 / 2) - 0.5))
/**
 Function draws 6 base arcs for semi circular progress view. Started the base semicircle with 0.02 spacing and ended with same to have equal arcs with size - 0.06 & space 0.02

  - Parameter: baseColor Color Color for base arc
  - Parameter: arcWidth CGFloat width of arc
  - Returns: View Circular arcs
 */
func drawBaseSemiCircleArcs(baseColor: Color, arcWidth: CGFloat) -> some View {
  // Step1: Draws 6 base circular arcs of equal parts
  ZStack {
    SemiCircleArc(startPoint: 0.52, endPoint: 0.58, arcColor: baseColor, arcWidth: arcWidth)
    SemiCircleArc(startPoint: 0.60, endPoint: 0.66, arcColor: baseColor, arcWidth: arcWidth)
    SemiCircleArc(startPoint: 0.68, endPoint: 0.74, arcColor: baseColor, arcWidth: arcWidth)
    SemiCircleArc(startPoint: 0.76, endPoint: 0.82, arcColor: baseColor, arcWidth: arcWidth)
    SemiCircleArc(startPoint: 0.84, endPoint: 0.90, arcColor: baseColor, arcWidth: arcWidth)
    SemiCircleArc(startPoint: 0.92, endPoint: 0.98, arcColor: baseColor, arcWidth: arcWidth)
  }
}

// MARK: - SemiCircleArc

/// Draws an arc of circle for given start and end point using .trim & .stroke functions of Circle
struct SemiCircleArc: View {
  @State
  var startPoint: Double
  @State
  var endPoint: Double
  @State
  var arcColor: Color
  @State
  var arcWidth: CGFloat

  var body: some View {
    Circle()
      .trim(from: startPoint, to: endPoint)
      .stroke(style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .round))
      .foregroundColor(arcColor)
  }
}

// MARK: - SemiCircleArcFill

/// Draws an arc of circle for given start and end point using .trim & .stroke functions of Circle. This struct is used to show the fill progress which has binding end point to end drawing of arc.
struct SemiCircleArcFill: View {
  @State
  var startPoint: Double
  @Binding
  var endPoint: Double
  @State
  var arcColor: Color
  @State
  var arcWidth: CGFloat

  var body: some View {
    Circle()
      .trim(from: startPoint, to: endPoint)
      .stroke(style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .round))
      .foregroundColor(arcColor)
  }
}

// MARK: - ProgressDot

/// Draws the progress consisting of two circles - outer & inner one. Outer circle uses base color & Inner circle uses fill color
struct ProgressDot: View {
  @State
  var baseColor: Color
  @Binding
  var fillColor: Color

  var body: some View {
    ZStack {
      Circle()
        .fill(baseColor)
        .frame(width: 28, height: 28)
      Circle()
        .fill(fillColor)
        .frame(width: 10, height: 10)
    }
  }
}
