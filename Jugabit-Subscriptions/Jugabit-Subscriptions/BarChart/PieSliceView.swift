//
//  PieSliceView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct PieSliceView: View {
    var pieSliceData: PieSliceData

    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let center = CGPoint(x: width / 2, y: height / 2)
            let radius = min(width, height) / 2

            Path { path in
                path.move(to: center)
                path.addArc(center: center,
                            radius: radius,
                            startAngle: pieSliceData.startAngle,
                            endAngle: pieSliceData.endAngle,
                            clockwise: false)
            }
            .fill(pieSliceData.color)

            Text(String(format: "%.0f%%", pieSliceData.value * 100))
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .background(Color.black.opacity(0.75))
                .clipShape(Capsule())
                .position(
                    x: center.x + radius * 0.6 * CGFloat(cos(midRadians)),
                    y: center.y - radius * 0.6 * CGFloat(sin(midRadians))
                )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
