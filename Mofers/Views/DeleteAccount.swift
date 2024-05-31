//
//  DeleteAccount.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-05.
//

import SwiftUI

struct DeleteAccount: View {

    @State var login: Bool = false

    var body: some View {
        GeometryReader { bounds in
            VStack {
                VStack(alignment: .leading, spacing: 30) {
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "deleteAccount"))
                        .padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 10) {
                        delAccountHeader(bounds: bounds)
                    }
                    CustomTile(title: "delAccountReason1", size: bounds.size)
                    CustomTile(title: "delAccountReason2", size: bounds.size)
                    CustomTile(title: "delAccountReason3", size: bounds.size)
                    CustomTile(title: "delAccountReason4", size: bounds.size)

                    //                    VStack(alignment: .leading) {
                    //                        Text(translate(key: "delAccountReason1"))
                    //                            .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
                    //                        Divider()
                    //                    }
                    //                    VStack(alignment: .leading) {
                    //                        Text(translate(key: "delAccountReason2"))
                    //                            .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
                    //                        Divider()
                    //                    }
                    //                    VStack(alignment: .leading) {
                    //                        Text(translate(key: "delAccountReason3"))
                    //                            .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
                    //                        Divider()
                    //                    }
                    //                    VStack(alignment: .leading) {
                    //                        Text(translate(key: "delAccountReason4"))
                    //                            .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
                    //                        Divider()
                    //                    }
                    Spacer()
                }
                VStack(alignment: .center, spacing: 10) {
                    deleteAccountButton(bounds: bounds)
                    changeMindButton(bounds: bounds)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(.white)
                .shadow(color: .black.opacity(0.1), radius: 3)
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 10)
        }
    }


    struct CustomTile: View {

        var title: LocalizedStringKey
        var size: CGSize

        var body: some View {
            VStack(alignment: .leading) {
                Text(translate(key: title))
                    .font(.system(size: size.width > breakPoint ? 30 : 18))
                Divider()
            }
        }
    }

    func deleteAccountButton(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            ZStack {
                NavigationLink(destination: CustomDeleteRequest(width: bounds.size.width)) {
                    Text(translate(key: "delAccount"))
                        .foregroundColor(.white)
                        .font(.system(size: bounds.size.width > breakPoint ? 25 : 16, weight: .semibold))
                }
                .frame(width: bounds.size.width * 0.9, height: bounds.size.height * 0.07)
                .background(Color(hex: 0xEA1818))
                .cornerRadius(10)
            }
        }
        .buttonStyle(NoAnim())
    }

    func changeMindButton(bounds: GeometryProxy) -> some View {
        Button {
            self.login = true
        } label: {
            ZStack {
                Text(translate(key: "changeMind"))
                    .foregroundColor(.white)
                    .font(.system(size: bounds.size.width > breakPoint ? 25 : 16, weight: .semibold))
            }
            .frame(width: bounds.size.width * 0.9, height: bounds.size.height * 0.07)
            .background(Color(hex: 0x49405F))
            .cornerRadius(10)
        }
        .buttonStyle(NoAnim())
    }

    func delAccountHeader(bounds: GeometryProxy) -> some View {
        return Text(translate(key: "delAccountTitle"))
            .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
        Text(translate(key: "delAccountDiscription"))
            .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
            .foregroundColor(.gray)
    }


}

struct DeleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccount()
    }
}


struct CustomDeleteRequest: View {

    var width: CGFloat

    var body: some View {
        VStack {
            Text(translate(key: "delAccount"))
                .foregroundColor(Color(hex: 0x010F07))
                .font(.system(size: width / 25, weight: .medium))
            Spacer()
            VStack(spacing: 20) {
                Text(translate(key: "request"))
                    .foregroundColor(Color(hex: 0xF4E6E6))
                    .font(.system(size: width / 18, weight: .semibold))
                Text(translate(key: "requestTitle"))
                    .foregroundColor(Color(hex: 0xFFFFFF))
                    .font(.system(size: width / 15, weight: .semibold))
                Text(translate(key: "requestDiscription"))
                    .foregroundColor(Color(hex: 0xE8E4F4))
                    .font(.system(size: width / 15, weight: .regular))
            }
            .frame(width: .infinity, height: width / 3)
            .padding(20)
            .background(Color(hex: 0x6B5D96))
            .cornerRadius(10)
            Spacer()
        }
        .frame(width: .infinity, height: .infinity)
        .navigationBarHidden(true)
    }
}


