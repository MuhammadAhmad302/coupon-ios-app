//
//  CustomBackButton.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-04.
//

import SwiftUI

struct CustomNavigationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var width: CGFloat
    var icon: String
    var title: LocalizedStringKey
    var isRoot: Bool = false
    
    
    var body: some View {
        HStack {
            Button {
                isRoot ? UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView()) :
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                ZStack {
                    Image(systemName: icon)
                        .font(.system(size: width / 35))
                        .padding(20)
                }
                .frame(width: width / 15, height: width / 15)
                .background(.white)
                .cornerRadius(10)
                .opacity(0.7)
            }
            .shadow(color: Color.gray.opacity(0.3), radius: 5)
            .buttonStyle(NoAnim())
            Spacer()
            Text(title)
                .font(.system(size: width / 25, weight: .medium))
                .padding(.trailing, 50)
            Spacer()
        }
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(width: 600, icon: "chevron.backward", title: "More")
    }
}
