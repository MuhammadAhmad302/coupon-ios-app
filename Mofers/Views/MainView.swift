//
//  MainView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI
import Combine


struct CustomTabView: View {

    struct Tab {
        let icon: String
        let label: LocalizedStringKey
        let tag: Int
        let view: AnyView
    }

    @State private var selectedTab = 0
    @State private var isSavedSelected = false
    @StateObject var locationManager = LocationManager()
    var selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "ar"


    let tabs = [
        Tab(icon: "homeIcon", label: translate(key: "home"), tag: 0, view: AnyView(Home())),
        Tab(icon: "categoryIcon", label: translate(key: "categories"), tag: 1, view: AnyView(CategoryGrid())),
        Tab(icon: "saveIcon", label: translate(key: "saved"), tag: 2, view: AnyView(NavigationView {
            CardsPage(isFill: true, isResturent: true)
        }
            .navigationViewStyle(.stack))),
        Tab(icon: "notificationIcon", label: translate(key: "notification"), tag: 3, view: AnyView(NotificationList())),
        Tab(icon: "profileIcon", label: translate(key: "profile"), tag: 4, view: AnyView(MoreScreen(isOpenSheet: false)))
    ]

    var body: some View {
        GeometryReader { bounds in
            VStack {
                tabs[selectedTab].view
                Spacer()
                HStack(spacing: bounds.size.width > breakPoint ? 0 : 0) {
                    ForEach(tabs, id: \.tag) { tab in
                        Button(action: {
                            selectedTab = tab.tag
                        }, label: {
                            VStack {
                                Image(tab.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: bounds.size.width > breakPoint ? 50 : 30, height: bounds.size.width > breakPoint ? 50 : 30)
                                Text(tab.label)
                                    .font(.system(size: bounds.size.width > breakPoint ? 23 : 12))
                                    .foregroundColor(selectedTab == tab.tag ? .black : .gray)
                                    .lineLimit(1)
                            }
                            .padding(.bottom, 0)
                            .frame(width: bounds.size.width / 5)
                        })
                        .buttonStyle(NoAnim())
                    }
                }
            }
            .environment(\.locale, .init(identifier: selectedLanguage))
            .environment(\.layoutDirection, selectedLanguage  == "ar" ? .rightToLeft : .leftToRight)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onAppear {
                locationManager.requestLocation()
            }
        }
    }
}
    func getSavedView() -> AnyView {
        return AnyView(NavigationView {
            CardsPage(isFill: true, isResturent: true, foodStreet: "Street Food", Cafe: "Cafe")
        }
            .navigationViewStyle(.stack))
    }
