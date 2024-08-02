//
//  PieChartView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct BarChartView: View {
    var data: [Double]
    var labels: [String]

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let maxValue = data.max() ?? 1
            let barWidth = width / CGFloat(data.count)

            HStack(alignment: .bottom, spacing: 2) {
                ForEach(0..<data.count, id: \.self) { index in
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: barWidth - 4, height: CGFloat(data[index]) / CGFloat(maxValue) * height)
                        Text(labels[index])
                            .font(.caption)
                            .rotationEffect(.degrees(-45))
                            .frame(width: barWidth, height: 20, alignment: .center)
                    }
                }
            }
        }
        .padding()
    }
}
