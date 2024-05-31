
import Foundation
import SwiftUI
import Firebase
import CryptoKit
import FirebaseFirestore
import AuthenticationServices

class SignIn_WithAppleButton: ObservableObject {
    @AppStorage("log_State") var log_State = false
    @Published var nonce = ""
    @Published var should_Navigate: Bool = false
    @State var isLoading = false

    func SigninWithAppleRequest(_ request: ASAuthorizationOpenIDRequest) {
        nonce = randomNonceString()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }

    func SigninWithAppleCompletion(_ request: Result<ASAuthorization, Error>) {
        switch request {
        case .success (let user):
            guard let crediential = user.credential as? ASAuthorizationAppleIDCredential else {
                print("Crediential 23")
                return
            }
            guard let token = crediential.identityToken else {
                print("error with token")
                return
            }
            guard let tokenString = String(data: token, encoding: .utf8) else {
                print("error with tokenString")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce, accessToken: crediential.fullName?.givenName)

            Task {
                do {
                    try await Auth.auth().signIn(with: credential)
                    guard let user = Auth.auth().currentUser else {
                        return
                    }
                    print(user)
                    let userName = extractUsername(from: user.email ?? "")
                    print(userName)
                    print("apple credential \(user)")
                    DispatchQueue.main.async {
                        self.isLoading = true
                        self.should_Navigate = true
                        self.log_State = true
                        print(credential)
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                    }
                } catch {
                    print("error 45")
                    self.isLoading = false
                }
            }

        case .failure (let failure):
            self.should_Navigate = false
            self.isLoading = false
            print(failure.localizedDescription)
        }
    }

}

private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()

    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length

    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }

        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }

            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }

    return result
}


func extractUsername(from string: String) -> String {
    let emailRegex = try! NSRegularExpression(pattern: "\\b([A-Za-z0-9._%+-]+)@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}\\b", options: [])

    var cleanedString = string

    let emailMatches = emailRegex.matches(in: cleanedString, options: [], range: NSRange(location: 0, length: cleanedString.utf16.count))
    for match in emailMatches.reversed() {
        let usernameRange = match.range(at: 1)
        cleanedString = (cleanedString as NSString).substring(with: usernameRange)
    }

    return cleanedString.trimmingCharacters(in: .whitespacesAndNewlines)
}
