//
//  myTab.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI
import SuperTabBar

enum MainTab {
    case information
    case plus
    case subscriptions
}

extension MainTab: SuperTab {
    var icon: String {
        switch self {
        case .information:
            return "info.circle"
        case .plus:
            return "plus"
        case .subscriptions:
            return "list.clipboard"
        }
    }

    var selectedIcon: String {
        switch self {
        case .information:
            return "info.circle.fill"
        case .plus:
            return "plus"
        case .subscriptions:
            return "list.clipboard.fill"
        }
    }

    var title: String {
        switch self {
        case .information:
            return "Info"
        case .plus:
            return "Add"
        case .subscriptions:
            return "Subs"
        }
    }

    var customTabView: AnyView? {
        if self == .plus {
            return AnyView(ZStack {})
        } else {
            return AnyView(
                VStack {
                    Image(systemName:icon)
                    Text(title)
                }
                .foregroundColor(.white.opacity(0.7))
            )
        }
    }

    var customSelectedTabView: AnyView? {
        AnyView(
            VStack {
                Image(systemName:selectedIcon)
                Text(title)
            }
            .foregroundColor(.white)
        )
    }
}
