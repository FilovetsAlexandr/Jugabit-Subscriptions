//
//  OnboardingView.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI
import Lottie

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Jugabit Subscription Manager")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            LottieView(animationName: "list")
                .frame(width: 100, height: 100)
                .padding()
            Spacer()
            Button(action: {
                showOnboarding = false
            }) {
                Text("Get Started")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
}

struct LottieView: UIViewRepresentable {
    var animationName: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = LottieAnimationView()
        view.animation = LottieAnimation.named(animationName)
        view.loopMode = .loop
        view.play()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

//#Preview {
//    OnboardingView()
//}
