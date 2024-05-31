//
//  MapScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-10.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.43775599), span: MKCoordinateSpan(latitudeDelta: 60.0, longitudeDelta: 60.0))
    @State var searchText = ""
    
    var body: some View {
        GeometryReader { bounds in
            VStack {
                CustomSearchFeild(width: bounds.size.width, searchText: $searchText)
                    .padding(.horizontal, 10)
                Map(coordinateRegion: $region)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                NavigationLink(destination: CustomTabView()) {
                    PrimaryButton(btnWidth: .infinity, btnText: translate(key: "confirmLocation"), color: Color(hex: 0x49425E), width: bounds.size.width, height: bounds.size.height / 15)
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
