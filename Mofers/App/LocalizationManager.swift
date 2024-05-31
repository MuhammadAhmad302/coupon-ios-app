////
////  LocalizationManager.swift
////  Mofers
////
////  Created by Rashdan Natiq on 2023-03-08.
////
//
import SwiftUI
import Foundation

/// //////////////////////////////////


//class LanguageManager: ObservableObject {
//    @Published var currentLanguage: String
//
//    init() {
//        self.currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
//    }
//
//    func setLanguage(_ languageCode: String) {
//        let newLocale = Locale(identifier: languageCode)
//        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        Bundle.main.loadLanguage(languageCode: languageCode)
//        self.currentLanguage = languageCode
//    }
//}

//extension Bundle {
//    func loadLanguage(languageCode: String) {
//        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else { return }
//        guard let bundle = Bundle(path: path) else { return }
//        object_setClass(self, bundle.classNamed("NSBundle")!)
//    }
//}
