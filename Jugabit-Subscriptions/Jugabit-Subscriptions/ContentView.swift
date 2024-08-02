//
//  ContentView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = true
    @State private var subscriptions: [Subscription] = FileManagerHelper.loadSubscriptions()

    var body: some View {
        if showOnboarding {
            OnboardingView(showOnboarding: $showOnboarding)
        } else {
            MainTabBarView(subscriptions: $subscriptions)
        }
    }
}



#Preview {
    ContentView()
}
