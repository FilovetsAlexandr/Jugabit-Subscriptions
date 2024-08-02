//
//  ActiveButtonView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI
import SuperTabBar

struct MainTabBarView: View {
    @Binding var subscriptions: [Subscription]
    @State private var isPresented = false
    @State private var selectedTab = MainTab.information

    var body: some View {
        SuperTabBar(selection: $selectedTab) {
            SubscriptionsView(subscriptions: $subscriptions)
                .tabItem(for: MainTab.subscriptions)
            Text("")
                .tabItem(for: MainTab.plus)
            InformationView(subscriptions: $subscriptions)
                .tabItem(for: MainTab.information)
        }
        .tabBarStyle(MainTabBarStyle(onButtonClicked: {
            isPresented.toggle()
        }))
        .sheet(isPresented: $isPresented) {
            AddSubscriptionView(subscriptions: $subscriptions)
        }
        .onChange(of: subscriptions) { newValue in
            FileManagerHelper.saveSubscriptions(newValue)
        }
    }
}




struct MainTabBarView_Previews: PreviewProvider {
    @State static var sampleSubscriptions: [Subscription] = []

    static var previews: some View {
        MainTabBarView(subscriptions: $sampleSubscriptions)
    }
}
