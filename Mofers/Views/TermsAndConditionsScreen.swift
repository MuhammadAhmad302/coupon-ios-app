//
//  RateUsScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-06.
//

import SwiftUI

struct TermsAndConditionsScreen: View {
    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .leading, spacing: 30) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "termAndCondition"))
                    .padding(.bottom, 20)
                VStack(alignment: .leading, spacing: 10) {
                    terms_ConditionCell(bounds: bounds, title: "groupTitle1")
                    terms_ConditionCell(bounds: bounds, title: "groupDiscription1")
                        .foregroundColor(.gray)
                }
                terms_ConditionCell(bounds: bounds, title: "groupTitle2")
                terms_ConditionCell(bounds: bounds, title: "groupTitle3")
                terms_ConditionCell(bounds: bounds, title: "groupTitle4")
                terms_ConditionCell(bounds: bounds, title: "groupTitle5")
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 10)
        }
    }

    func terms_ConditionCell(bounds: GeometryProxy, title: LocalizedStringKey) -> some View {
        VStack(alignment: .leading) {
            Text(translate(key: title))
                .font(.system(size: bounds.size.width > breakPoint ? 30 : 15))
            Divider()
        }
    }

}

struct RateUsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsScreen()
    }
}
