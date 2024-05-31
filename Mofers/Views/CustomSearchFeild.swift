//
//  CustomSearchFeild.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct CustomSearchFeild: View {

    @State private var showCancelButton: Bool = true
    var controller: Bool = false
    var width: CGFloat
    @Binding var searchText: String

    var body: some View {
        HStack {
            HStack {
                magnifyingGlassImage()
                customTextFeild()
                crossButton()
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .accentColor(.white)
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .frame(height: width / 10)
            .cornerRadius(10.0)
        }.padding(.bottom, 10)

    }

    func magnifyingGlassImage() -> some View {
        Image(systemName: "magnifyingglass")
            .font(.system(size: width / 20))
    }

    func customTextFeild() -> some View {
        TextField(controller ? translate(key: "placeholderRestaurant") : translate(key: "placeholderCafe"), text: $searchText, onEditingChanged: { isEditing in
            self.showCancelButton = true
        }, onCommit: {
            print("onCommit")
        })
        .font(.system(size: width / 20))
        .foregroundColor(.primary)
        .accentColor(.white)
    }

    func crossButton() -> some View {
        Button(action: {
            self.searchText = ""
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: width / 20))
                .opacity(searchText == "" ? 0 : 1)
        }

    }

}



