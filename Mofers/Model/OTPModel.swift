//
//  OTPViewModel.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-11.
//

import SwiftUI

class OTPModel: ObservableObject {
    @Published var otpText: String = ""
    @Published var otpFeilds: [String] = Array(repeating: "", count: 6)
}
