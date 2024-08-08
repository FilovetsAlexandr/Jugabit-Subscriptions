//
//  EditSubscriptionView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct EditSubscriptionView: View {
    @Binding var subscription: Subscription
    @State private var selectedImage: UIImage? = nil
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subscription Details")) {
                    TextField("Name", text: $subscription.name)
                    PeriodSelectionView(selectedPeriod: Binding(get: {
                        SubscriptionPeriod(rawValue: subscription.period) ?? .month
                    }, set: {
                        subscription.period = $0.rawValue
                    }))
                    TextField("Price", value: $subscription.price, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    HStack {
                        if let iconData = subscription.iconData, let uiImage = UIImage(data: iconData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } else {
                            Text("Select Image")
                        }
                        Spacer()
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Image(systemName: "photo")
                                 .foregroundColor(.indigo)
                        }
                    }
                }
                Button(action: {
                    if let selectedImage = selectedImage {
                        subscription.iconData = selectedImage.jpegData(compressionQuality: 1.0)
                    }
                    FileManagerHelper.saveSubscriptions([subscription])
                    // Dismiss view
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.horizontal)
                }
            }
            .navigationBarTitle("Edit Subscription", displayMode: .inline)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}
