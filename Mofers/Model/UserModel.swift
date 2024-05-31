//
//  UserModel.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-31.
//

import Foundation
import AuthenticationServices


struct _User: Codable {
    var fullName: String
    var email: String
    var dateOfBirth: String
    var password: String
    var phoneNumber: String

    init(fullName: String, email: String, dateOfBirth: String, password: String, phoneNumber: String) {
        self.fullName = fullName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.password = password
        self.phoneNumber = phoneNumber
    }

    init?(data: [String: Any]) {
        guard let fullName = data["fullName"] as? String,
              let email = data["email"] as? String,
              let dateOfBirth = data["dateOfBirth"] as? String,
              let password = data["password"] as? String,
              let phoneNumber = data["phoneNumber"] as? String

        else {
            return nil
        }

        self.fullName = fullName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.password = password
        self.phoneNumber = phoneNumber
    }
}


struct AppleUser: Codable {
    let userId: String
    let fullName: String
    let email: String

    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
            let fullName = credentials.fullName?.givenName,
            let email = credentials.email
        else { return nil }

        self.userId = credentials.user
        self.fullName = fullName
        self.email = email
    }
}


func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        request.nonce = ""
    }

func handle(_ authResult: Result<ASAuthorization, Error>) {
    switch authResult {
    case .success(let auth):
        print(auth)
        switch auth.credential {
        case let appleIdCredentials as ASAuthorizationAppleIDCredential:
            if let appleUser = AppleUser(credentials: appleIdCredentials),
               let appleUserData = try? JSONEncoder().encode(appleUser) {
                UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)

                print("saved apple user", appleUser)
            } else {
                print("missing some fields", appleIdCredentials.email, appleIdCredentials.fullName, appleIdCredentials.user)

                guard
                    let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                    let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                else { return }

                print(appleUser)
            }

        default:
            print(auth.credential)
        }

    case .failure(let error):
        print(error)
    }
}
