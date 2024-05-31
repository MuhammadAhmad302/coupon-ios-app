//
//  MofersApp.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
//import TwitterKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FBSDKCoreKit.ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        FirebaseApp.configure()
//        FirebaseTwitterAuth.configure()
//        let loginButton = FBLoginButton()
//        loginButton.delegate
//        Settings.appID = "1682670432163061"
//        if let urlScheme = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLSchemes") as? String {
//                Settings.appID = urlScheme
//            }
        return true
    }


//    private func application(
//        _ app: UIApplication,
//        open url: URL,
//        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//    ) -> Bool {
//        ApplicationDelegate.shared.application(
//            app,
//            open: url,
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//        )
//    }


//    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        } else {
//            let credential = FacebookAuthProvider
//                .credential(withAccessToken: AccessToken.current!.tokenString)
//        }
//    }

        func application(_ app: UIApplication,
                         open url: URL,
                         options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
          return GIDSignIn.sharedInstance.handle(url)
        }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }


        func application(_ app: UIApplication,
                             open url: URL,
                             options: [UIApplication.OpenURLOptionsKey : Any]? = nil) -> Bool {
            return ApplicationDelegate.shared.application(app, open: url, options: options!)
        }
}


@main

struct MofersApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "ar"

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.locale, .init(identifier: selectedLanguage))
                .environment(\.layoutDirection, selectedLanguage  == "ar" ? .rightToLeft : .leftToRight)
        }
    }
}
