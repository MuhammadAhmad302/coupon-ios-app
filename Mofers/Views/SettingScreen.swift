//
//  SettingScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct SettingScreen: View {
    
    @State var isOpenSheet: Bool = false
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 25) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "setting"))
                    .padding(.bottom, 20)
                languageButton(bounds: bounds)
                deleteAccountButton(bounds: bounds)
                Spacer()
                saveButton(bounds: bounds)
            }
            .sheet(isPresented: $isOpenSheet) {
                LanguageBottomSheet(isOpenSheet: $isOpenSheet)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(.white)
                    .shadow(color: .black.opacity(0.1), radius: 3)
                    .presentationDetents([.height(200)])
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 10)
        }
    }

    func languageButton(bounds: GeometryProxy) -> some View {
        VStack(spacing: 25) {
            HStack {
                Button {
                    self.isOpenSheet = true
                } label: {
                    Text("language")
                        .foregroundColor(.black)
                        .font(.system(size: bounds.size.width > breakPoint ? 28 : 18, weight: .regular))
                }
                .buttonStyle(NoAnim())
                Spacer()
                Button {
                    self.isOpenSheet = true
                } label: {
                    Text(translate(key: "english"))
                        .foregroundColor(.black)
                        .font(.system(size: bounds.size.width > breakPoint ? 25 : 15, weight: .regular))
                }
                .buttonStyle(NoAnim())
            }
            Divider()
                .frame(width: bounds.size.width * 0.9)
        }
    }

    func deleteAccountButton(bounds: GeometryProxy) -> some View {
        NavigationLink(destination: DeleteAccount()) {
            VStack {
                HStack {
                    Text(translate(key: "deleteAccount"))
                        .foregroundColor(.black)
                        .font(.system(size: bounds.size.width > breakPoint ? 28 : 18, weight: .regular))
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                        .font(.system(size: bounds.size.width > breakPoint ? 25 : 15, weight: .regular))
                }
                Divider()
                    .frame(width: bounds.size.width * 0.9)
            }
        }
        .buttonStyle(PlainButtonStyle())

    }

    struct LanguageBottomSheet: View {

        @Binding var isOpenSheet: Bool

        var body: some View {
            GeometryReader { bounds in
                VStack(spacing: 20) {
                    headerView(bounds: bounds)
                    languagesSection(bounds: bounds)
                }
            }
        }

        func languagesSection(bounds: GeometryProxy) -> some View {
            VStack {
                Button {
                    UserDefaults.standard.set("en", forKey: "selectedLanguage")
                    UserDefaults.standard.synchronize()
                    self.isOpenSheet = false
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView(
                    ))
                    self.isOpenSheet = false
                } label: {
                    Text(translate(key: "english"))
                        .foregroundColor(Color(hex: 0x010F07))
                        .font(.system(size: bounds.size.width > breakPoint ? 24 : 14, weight: .regular))
                }
                .buttonStyle(NoAnim())
                Divider()

                Button {
                    UserDefaults.standard.set("ar", forKey: "selectedLanguage")
                    UserDefaults.standard.synchronize()
                    self.isOpenSheet = false
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                    self.isOpenSheet = false
                } label: {
                    Text(translate(key: "arabic"))
                        .foregroundColor(Color(hex: 0x010F07))
                        .font(.system(size: bounds.size.width > breakPoint ? 24 : 14, weight: .regular))
                }
                .buttonStyle(NoAnim())
                Divider()
                Button {
                    self.isOpenSheet = false
                } label: {
                    ZStack {
                        Text(translate(key: "cancel"))
                            .foregroundColor(.white)
                            .font(.system(size: bounds.size.width > breakPoint ? 26 : 16, weight: .semibold))
                    }
                    .frame(width: bounds.size.width * 0.9, height: 50)
                    .background(Color(hex: 0x49405F))
                    .cornerRadius(10)
                }
                .buttonStyle(NoAnim())
            }
        }

        func headerView(bounds: GeometryProxy) -> some View {
            Text(translate(key: "selectLanguage"))
                .foregroundColor(.gray)
                .font(.system(size: bounds.size.width > breakPoint ? 20 : 10, weight: .regular))
                .padding(.top, 10)
        }

    }

    func saveButton(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            ZStack {
                Text(translate(key: "save"))
                    .foregroundColor(.white)
                    .font(.system(size: bounds.size.width > breakPoint ? 26 : 16, weight: .semibold))
            }
            .frame(width: bounds.size.width * 0.9, height: bounds.size.height * 0.07)
            .background(Color(hex: 0x49405F))
            .cornerRadius(10)
        }
        .buttonStyle(NoAnim())
    }
}

