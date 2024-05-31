//
//  More.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct MoreScreen: View {
    
    @State var isTogglePushNotification: Bool = false
    @State var isToggleEmailNotification: Bool = false
    @State var isOpenSheet: Bool = false
    @State var logOutShowAlert: Bool = false
    @State var rateUSShowAlert: Bool = false
    @State var language: String?
    var isSuggest: Bool = true
    var user = UserViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { bounds in
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "more"), isRoot: true)
                            .padding(.bottom, 20)
                        settingSection(bounds: bounds)
                        manageSection(bounds: bounds)
                        notificationSection(bounds: bounds)
                        MoreSection(width: bounds.size.width)
                    }
                    .navigationBarHidden(true)
                    .padding(.horizontal, 10)
                }
                .padding(.bottom, 20)
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $isOpenSheet) {
            EditCityScreen()
                .background(.white)
                .shadow(color: .black.opacity(0.1), radius: 3)
                .padding(.horizontal, 20)
                .presentationDetents([.height(300)])
        }
    }

    func settingSection(bounds: GeometryProxy) -> some View {
        NavigationLink(destination: SettingScreen()) {
            CustomTile(width: bounds.size.width, leadingIcon: "settingIcon", title: translate(key: "settings"), subTitle: translate(key: "settingSubTitle"), tralingIcon: "chevron.forward", isSuggest: true)
                .padding(isSuggest ? EdgeInsets.init(top: 0, leading: bounds.size.width > breakPoint ? 10 : 3, bottom: 0, trailing: 0) : EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .buttonStyle(PlainButtonStyle())
    }

    func manageSection(bounds: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(translate(key: "manage"))
                .font(.system(size: bounds.size.width / 25))
            NavigationLink(destination: EditProfileScreen()) {
                CustomTile(width: bounds.size.width, leadingIcon: "profilleIcons", title: translate(key: "editProfile"), subTitle: translate(key: "editProfileTitle"), tralingIcon: "chevron.forward")
            }
            .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: ChangePasswordScreen()) {
                CustomTile(width: bounds.size.width, leadingIcon: "lockIcon", title: translate(key: "changePassword"), subTitle: translate(key: "changePasswordTitle"), tralingIcon: "chevron.forward")
            }
            .buttonStyle(PlainButtonStyle())
            Button {
                isOpenSheet.toggle()
            } label: {
                CustomTile(width: bounds.size.width, leadingIcon: "cityIcon", title: translate(key: "editCity"), subTitle: translate(key: "editCityTitle"), tralingIcon: "chevron.forward")
            }
            .buttonStyle(NoAnim())
        }
    }

    func notificationSection(bounds: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(translate(key: "notification"))
                .font(.system(size: bounds.size.width / 25))
            HStack(spacing: 20) {
                Image("notificationIcons")
                    .resizable()
                    .frame(width: bounds.size.width / 15, height: bounds.size.width / 15)
                VStack(alignment: .leading, spacing: 5) {
                    Text(translate(key: "pushNotification"))
                        .font(.system(size: bounds.size.width / 30, weight: .regular))
                    Text(translate(key: "pushNotificationTitle"))
                        .foregroundColor(.gray)
                        .font(.system(size: bounds.size.width / 30, weight: .regular))
                }
                Spacer()
                Toggle("", isOn: $isTogglePushNotification)
            }
            HStack(spacing: 20) {
                Image("emailIcon")
                    .resizable()
                    .frame(width: bounds.size.width / 15, height: bounds.size.width / 15)
                VStack(alignment: .leading, spacing: 5) {
                    Text(translate(key: "emailNotification"))
                        .font(.system(size: bounds.size.width / 30, weight: .regular))
                    Text(translate(key: "emailNotificationTitle"))
                        .foregroundColor(.gray)
                        .font(.system(size: bounds.size.width / 30, weight: .regular))
                }
                Spacer()
                Toggle("", isOn: $isToggleEmailNotification)
            }
        }
    }

    struct MoreSection: View {

        @AppStorage("log_State") var log_State = false
        @State var logOutShowAlert: Bool = false
        @State var rateUSShowAlert: Bool = false
        var isSuggest: Bool = true
        var width: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 35) {
                Text(translate(key: "more"))
                    .font(.system(size: width / 25))
                NavigationLink(destination: FAQScreen()) {
                    CustomNotSubTitle(width: width, leadingIcon: "faqIcon", title: translate(key: "faq"), tralingIcon: "chevron.forward")
                }
                .buttonStyle(PlainButtonStyle())
                NavigationLink(destination: TermsAndConditionsScreen()) {
                    CustomNotSubTitle(width: width, leadingIcon: "lockIcon", title: translate(key: "termsConditions"), tralingIcon: "chevron.forward")
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    rateUSShowAlert = true
                } label: {
                    CustomTile(width: width, leadingIcon: "Rate_icon", title: translate(key: "rateUs"), subTitle: translate(key: "rateUsTitle"), tralingIcon: "chevron.forward")
                }
                .buttonStyle(NoAnim())
                .alert(isPresented: $rateUSShowAlert) {
                    Alert(title: Text(translate(key: "rateUsAlertTitle")), message: Text(translate(key: "rateUsAlertSubTitle")), dismissButton: .cancel(Text(translate(key: "rateUsAlertAction"))))
                }
                NavigationLink(destination: SuggestScreen()) {
                    CustomNotSubTitle(width: width, leadingIcon: "Suggestion_icon", title: translate(key: "suggest"), tralingIcon: "chevron.forward", isSuggest: true)
                        .padding(isSuggest ? EdgeInsets.init(top: 0, leading: width > breakPoint ? 10 : 3, bottom: 0, trailing: 0) : EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .buttonStyle(PlainButtonStyle())
                if (Auth.auth().currentUser != nil) {
                    EmptyView()
                } else {
                    NavigationLink(destination: LoginScreen()) {
                        CustomNotSubTitle(width: width, leadingIcon: "lockIcon", title: translate(key: "login"), tralingIcon: "chevron.forward")
                            .buttonStyle(PlainButtonStyle())
                    }
                }

                if (Auth.auth().currentUser != nil) {
                  // User is signed in.
                  // ...
                    Button {
                        logOutShowAlert = true
                    } label: {
                        CustomNotSubTitle(width: width, leadingIcon: "logOutIcon", title: translate(key: "logout"), tralingIcon: "chevron.forward")
                    }
                    .buttonStyle(NoAnim())
                    .alert(isPresented: $logOutShowAlert) {
                        Alert(title: Text(translate(key: "logoutAlertTitle")), message: Text(translate(key: "logoutAlertSubTitle")), primaryButton: .cancel(Text(translate(key: "logoutAlertAction1"))), secondaryButton: .destructive(Text(translate(key: "logoutAlertTitleAction2")), action: {
                            let firebaseAuth = Auth.auth()
                            do {
                                try firebaseAuth.signOut()
                                print("Logout Successfully")
                                UserDefaults.standard.removeObject(forKey: "fullName")
                                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)
                            }
                        }))
                    }
                } else {
                  // No user is signed in.
                  // ...
                    EmptyView()
    //            }

    //            if log_State {
    //                Button {
    //                    logOutShowAlert = true
    //                } label: {
    //                    CustomNotSubTitle(width: width, leadingIcon: "logOutIcon", title: translate(key: "logout"), tralingIcon: "chevron.forward")
    //                }
    //                .buttonStyle(NoAnim())
    //                .alert(isPresented: $logOutShowAlert) {
    //                    Alert(title: Text(translate(key: "logoutAlertTitle")), message: Text(translate(key: "logoutAlertSubTitle")), primaryButton: .cancel(Text(translate(key: "logoutAlertAction1"))), secondaryButton: .destructive(Text(translate(key: "logoutAlertTitleAction2")), action: {
    //                        let firebaseAuth = Auth.auth()
    //                        do {
    //                            try firebaseAuth.signOut()
    //                            print("Logout Successfully")
    //                            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
    //                        } catch let signOutError as NSError {
    //                            print("Error signing out: %@", signOutError)
    //                        }
    //                    }))
    //                }
                }
            }
        }
    }

}

struct More_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen(isOpenSheet: true)
    }
}
