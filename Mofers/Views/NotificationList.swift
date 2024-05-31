//
//  NotificationList.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct NotificationList: View {
    
    var body: some View {
        GeometryReader { bounds in
            NavigationView {
                VStack() {
                    HeaderView(width: bounds.size.width, isRoot: true)
                        .frame(height: bounds.size.width > breakPoint ? 90 : 40)
                        .padding(.horizontal, 10)
                        .padding(.top, 40)
                    ScrollView {
                        ListCell(width: bounds.size.width)
                            .frame(height: bounds.size.height)
                    }
                    .ignoresSafeArea()
                    .navigationBarHidden(true)
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct NotificationList_Previews: PreviewProvider {
    static var previews: some View {
        NotificationList()
    }
}
