//
//  SliderImageView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI

struct SliderImageView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectedImageIndex = 0
    @State private var isDraggingImage = false
    @GestureState private var dragOffset: CGFloat = 0
    @StateObject var viewModel = OfferBannerViewModel()

    var width: CGFloat

    struct scrollImage {
        let image: String
        let title: LocalizedStringKey
        let subTitle: LocalizedStringKey
        let promoCode: LocalizedStringKey
    }

    var images: [scrollImage] = [
        scrollImage(image: "category8", title: translate(key: "off"), subTitle: translate(key: "sliderSubTitle"), promoCode: translate(key: "promoCode")),
        scrollImage(image: "category2", title: translate(key: "off"), subTitle: translate(key: "sliderSubTitle"), promoCode: translate(key: "promoCode")),
        scrollImage(image: "category6", title: translate(key: "off"), subTitle: translate(key: "sliderSubTitle"), promoCode: translate(key: "promoCode")),
    ]

    var body: some View {
        ZStack {
            if viewModel.offers.isEmpty {
                ProgressView()
            } else {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: width > breakPoint ? 25 : 15) {
                            ForEach(viewModel.offers.indices, id: \.self) { item in
                                imageView(bounds: width, item: item)
                            }
                        }
                        .padding(.horizontal, 10)
                        .onDrag({ NSItemProvider(object: UIImage(named: "image\(index)")!) })
                        .onChange(of: selectedImageIndex) { newValue in
                            print("Selected image index changed to \(newValue)")
                        }
                    }
                    indicatorView()
                }
            }
        }
        .onAppear {
            viewModel.fetchAllBannerOffer()
        }
    }

    func imageView(bounds: CGFloat, item: Int) -> some View {
        ZStack {
            AsyncImage(url: URL(string: viewModel.offers[item].image["0"]?.full.url ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width * 0.9, height: width > breakPoint ? 500 : 200)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .onAppear {
                isDraggingImage = true
            }
            .onDisappear {
                isDraggingImage = false
                selectedImageIndex = item
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { value, state, _ in
                        state = value.translation.width
                    })
                    .onChanged({ _ in
                        isDraggingImage = true
                    })
                    .onEnded({ value in
                        isDraggingImage = false
                        let threshold = width / 2
                        let offset = value.translation.width
                        if offset < -threshold && selectedImageIndex < images.count - 1 {
                            selectedImageIndex += 1
                        } else if offset > threshold && selectedImageIndex > 0 {
                            selectedImageIndex -= 1
                        }
                    })
            )
            Image("GradientView")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width * 0.9, height: width > breakPoint ? 500 : 200)
                .clipped()
                .overlay (
                    VStack(alignment: .leading) {
                        Text(viewModel.offers[item].title)
                            .font(.system(size: width / 20, weight: .heavy))
                        Text(viewModel.offers[item].status)
                            .font(.system(size: width / 24, weight: .bold))
                        Text(viewModel.offers[item].description)
                            .font(.system(size: width / 30, weight: .medium))
                    }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    , alignment: .leading
                )
        }
        .cornerRadius(15)

    }

    func indicatorView() -> some View {
        HStack(spacing: 10) {
            ForEach(0..<viewModel.offers.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(selectedImageIndex == index ? .black : .gray)
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        withAnimation {
                            selectedImageIndex = index
                        }
                    }
            }
        }
    }

}

struct SliderImageView_Previews: PreviewProvider {
    static var previews: some View {
        SliderImageView(width: 300)
    }
}
