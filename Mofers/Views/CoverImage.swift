//
//  CoverImage.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI
import Firebase

struct CoverImage: View {

    var width: CGFloat
    @AppStorage("log_State") var log_State = false
    @State var userName = UserDefaults.standard.string(forKey: "fullName") ?? ""

    var body: some View {
        ZStack {
            heroImage()
            VStack {
                Spacer()
                HStack {
                    CustomSearch(width: width)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading, 20)
                Spacer()
                if (Auth.auth().currentUser != nil) {
                    userNameSection(bounds: width)
                } else {
                    EmptyView()
                }
            }
        }
        // other code
    }

    func userNameSection(bounds: CGFloat) -> some View {
        HStack {
            HStack {
                if let userName = Auth.auth().currentUser?.displayName  {
                    Text("Hi, \(userName)") // display user's name here
                        .font(.system(size: width > breakPoint ? 26 : 16, weight: .semibold))
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(.yellow)
            .cornerRadius(5)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.leading, 20)
        .padding(.bottom, width > breakPoint ? 10 : 5)
    }

    func heroImage() -> some View {
        Image("CoverImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
    }

    struct CustomSearch: View {

        @State private var searchText = ""
        @State private var showCancelButton: Bool = true
        var controller: Bool = false
        var width: CGFloat

        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: width / 20))
                TextField("", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                })
                .placeholder(when: searchText.isEmpty, placeholder: {
                    Text(controller ? translate(key: "placeholderRestaurant") : translate(key: "placeholderCafe"))
                })
                .foregroundColor(.white)
                .font(.system(size: width / 20))

                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: width / 20))
                        .opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.white)
            .background(Color(hex: 0x706B6E, alpha: 0.7))
            .cornerRadius(10.0)
            .frame(width: width / 2,height: width / 15)
        }
    }

    struct textfeild: View {

        @State var text: String

        var body: some View {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("Placeholder recreated").foregroundColor(.black)
                }
        }
    }
}


struct CoverImage_Previews: PreviewProvider {
    static var previews: some View {
        CoverImage(width: 500)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
