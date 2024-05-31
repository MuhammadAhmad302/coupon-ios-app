//
//  FaQScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-05.
//

import SwiftUI

struct FAQScreen: View {
    
    struct faqData {
        let title: LocalizedStringKey
        let subTitle: LocalizedStringKey
    }
    
    var data: [faqData] = [
        faqData(title: translate(key: "groupTitle1"), subTitle: translate(key: "groupDiscription1")),
        faqData(title: translate(key: "groupTitle2"), subTitle: translate(key: "groupDiscription2")),
        faqData(title: translate(key: "groupTitle3"), subTitle: translate(key: "groupDiscription3")),
        faqData(title: translate(key: "groupTitle4"), subTitle: translate(key: "groupDiscription4")),
        faqData(title: translate(key: "groupTitle5"), subTitle: translate(key: "groupDiscription5"))
    ]
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 20) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "faq"))
                    .padding(.bottom, 20)
                ForEach(0..<5, id: \.self) { items in
                    GroupBox() {
                        DisclosureGroup("groupTitle1") {
                            HStack {
                                Group {
                                    Text("groupDiscription1")
                                        .font(.system(size: bounds.size.width > breakPoint ? 24 : 14, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                                .font(Font.system(.body).bold())
                                Spacer(minLength: 25)
                            }
                        }
                        .font(.system(size: bounds.size.width > breakPoint ? 30 : 15))
                        .accentColor(.black)
                    }
                }
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 10)
        }
    }
}

struct FAQScreen_Previews: PreviewProvider {
    static var previews: some View {
        FAQScreen()
    }
}
