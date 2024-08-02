//
//  SubscriptionListView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct SubscriptionsView: View {
    @Binding var subscriptions: [Subscription]
    @State private var selectedSubscription: Subscription?

    var body: some View {
        VStack {
            if subscriptions.isEmpty {
                VStack {
                    Spacer()
                    LottieView(animationName: "loop")
                        .frame(width: 100, height: 100)
                    Spacer()
                    Text("You haven't added any subscriptions yet")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
            } else {
                List {
                    ForEach($subscriptions) { $subscription in
                        HStack {
                            if let iconData = subscription.iconData, let uiImage = UIImage(data: iconData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                            VStack(alignment: .leading) {
                                Text(subscription.name)
                                    .font(.headline)
                                Text("\(subscription.period)")
                                    .font(.subheadline)
                                Text("$\(subscription.price, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                        }
                        .contextMenu {
                            Button(action: {
                                selectedSubscription = subscription
                            }) {
                                Text("Edit")
                                Image(systemName: "pencil")
                            }
                            Button(action: {
                                if let index = subscriptions.firstIndex(where: { $0.id == subscription.id }) {
                                    subscriptions.remove(at: index)
                                }
                            }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Subscriptions")
        .sheet(item: $selectedSubscription) { subscription in
            if let index = subscriptions.firstIndex(where: { $0.id == subscription.id }) {
                EditSubscriptionView(subscription: $subscriptions[index])
            }
        }
    }
}

struct SubscriptionsView_Previews: PreviewProvider {
    @State static var sampleSubscriptions: [Subscription] = []

    static var previews: some View {
        SubscriptionsView(subscriptions: $sampleSubscriptions)
    }
}

