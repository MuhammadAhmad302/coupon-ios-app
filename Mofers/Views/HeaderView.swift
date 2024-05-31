//
//  HeaderView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var width: CGFloat
    var isRoot: Bool = false
    
    var body: some View {
        HStack {
            backArrowButton(bounds: width)
            Spacer()
            logoView(bounds: width)
            Spacer()
            locationButton(bounds: width)
        }
    }

    func backArrowButton(bounds: CGFloat) -> some View {
        Button {
            isRoot ? UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView()) :
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: width / 35))
                    .padding(20)
            }
            .frame(width: width / 15, height: width / 15)
            .background(.white)
            .cornerRadius(7)
        }
        .shadow(color: Color.gray.opacity(0.3), radius: 5)
        .buttonStyle(NoAnim())
    }

    func logoView(bounds: CGFloat) -> some View {
        Button {

        } label: {
            ZStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: width / 7, height: width / 8)
            .offset(y: -40)
        }
    }

    func locationButton(bounds: CGFloat) -> some View {
        Button {

        } label: {
            ZStack {
                Rectangle()
                    .frame(width: width / 15, height: width / 15)
                    .foregroundColor(.black).opacity(0.7)
                    .cornerRadius(7)
                Image(systemName: "location.fill")
                    .foregroundColor(Color(hex: 0xFED372))
                    .font(.system(size: width / 25))
                    .padding(5)
            }
        }
        .buttonStyle(NoAnim())
    }

}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(width: 300)
    }
}
