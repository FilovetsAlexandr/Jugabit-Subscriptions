//
//  InformationView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct InformationView: View {
    @Binding var subscriptions: [Subscription]

    var totalSubscriptions: Int {
        subscriptions.count
    }

    var totalCostPerMonth: Double {
        subscriptions.reduce(0) { $0 + $1.price }
    }

    var mostExpensiveSubscription: Subscription? {
        subscriptions.max(by: { $0.price < $1.price })
    }

    var barChartData: [Double] {
        subscriptions.map { $0.price }
    }

    var barChartLabels: [String] {
        subscriptions.map { $0.name }
    }

    var body: some View {
        VStack {
            Text("Total Subscriptions: \(totalSubscriptions)")
                .font(.headline)
                .padding()
            Text("Total Monthly Cost: $\(totalCostPerMonth, specifier: "%.2f")")
                .font(.headline)
                .padding()
            if let mostExpensive = mostExpensiveSubscription {
                Text("Most Expensive: \(mostExpensive.name) - $\(mostExpensive.price, specifier: "%.2f")")
                    .font(.headline)
                    .padding()
            }
            BarChartView(data: barChartData, labels: barChartLabels)
                .frame(height: 300)
                .padding()
            Spacer()
        }
        .navigationBarTitle("Information", displayMode: .large)
    }
}
