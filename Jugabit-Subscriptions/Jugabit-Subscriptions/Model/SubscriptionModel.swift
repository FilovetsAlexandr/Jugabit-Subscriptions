//
//  SubscriptionModel.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//
import SwiftUI

struct Subscription: Identifiable, Codable, Equatable  {
    var id = UUID()
    var name: String
    var period: SubscriptionPeriod.RawValue
    var price: Double
    var iconData: Data?
    var icon: UIImage? {
           if let data = iconData {
               return UIImage(data: data)
           }
           return nil
       }
}
