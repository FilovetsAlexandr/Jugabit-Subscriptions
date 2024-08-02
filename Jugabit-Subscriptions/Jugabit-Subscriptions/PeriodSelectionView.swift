//
//  PeriodSelectionView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

enum SubscriptionPeriod: String, CaseIterable, Identifiable, Codable {
    case week = "Week"
    case month = "Month"
    case year = "Year"

    var id: String { self.rawValue }
}

struct PeriodSelectionView: View {
    @Binding var selectedPeriod: SubscriptionPeriod

    var body: some View {
        Picker("Subscription Period", selection: $selectedPeriod) {
            ForEach(SubscriptionPeriod.allCases) { period in
                Text(period.rawValue).tag(period)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
