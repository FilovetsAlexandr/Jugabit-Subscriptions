//
//  AddSubscriptionView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI

struct AddSubscriptionView: View {
    @Binding var subscriptions: [Subscription]
    @State private var name: String = ""
    @State private var selectedPeriod: SubscriptionPeriod = .month
    @State private var price: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showingImagePicker = false
    @Environment(\.presentationMode) var presentationMode

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subscription Details")) {
                    TextField("Name", text: $name)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    HStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
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
                                .foregroundColor(.black)
                        }
                    }
                    PeriodSelectionView(selectedPeriod: $selectedPeriod)
                }
                Button(action: {
                    if let priceValue = numberFormatter.number(from: price)?.doubleValue {
                        let iconData = selectedImage?.jpegData(compressionQuality: 1.0)
                        let newSubscription = Subscription(name: name, period: selectedPeriod.rawValue, price: priceValue, iconData: iconData)
                        subscriptions.append(newSubscription)
                        FileManagerHelper.saveSubscriptions(subscriptions)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add Subscription")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .navigationBarTitle("Add Subscription", displayMode: .inline)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    @State static var sampleSubscriptions: [Subscription] = []

    static var previews: some View {
        AddSubscriptionView(subscriptions: $sampleSubscriptions)
    }
}
