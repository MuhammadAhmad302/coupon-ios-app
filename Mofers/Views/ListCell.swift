//
//  ListCell.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct ListCell: View {

    var width: CGFloat

    struct ListModel: Codable, Hashable {
        let tilte: String
        let subTitle: String
    }

    var list: [ListModel] = [
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou"),
        ListModel(tilte: "Hello World!", subTitle: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layou")
    ]

    var body: some View {
        List {
            ForEach(list, id: \.self) { lst in
                HStack {
                    Image("bellIcon")
                        .resizable()
                        .frame(width: width / 20, height: width / 20)
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("notificationListTitle")
                                .font(.system(size: width / 25, weight: .regular))
                            Image(systemName: "alarm")
                                .font(.system(size:  width / 20))
                        }
                        Text("notificationListSubTitle")
                            .foregroundColor(.gray)
                            .font(.system(size: width / 30, weight: .regular))
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
    }
}
struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(width: 300)
    }
}
