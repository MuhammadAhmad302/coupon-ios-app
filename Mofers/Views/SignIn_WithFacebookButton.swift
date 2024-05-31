import SwiftUI
import CryptoKit
import Firebase
import FBSDKLoginKit

class FacebookLoginManager: NSObject, LoginButtonDelegate {

    let loginButton = FBLoginButton()
    var currentNonce: String?
    var viewController: UIViewController?

    override init() {
        super.init()
        self.setupLoginButton()
    }

    private func randomNonceString(length: Int = 32) -> String {
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

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    private func setupLoginButton() {
        let nonce = randomNonceString()
        currentNonce = nonce
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
//        loginButton.loginBehavior = .browser
        loginButton.nonce = sha256(nonce)
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let token = AccessToken.current else {
            print("Failed to get access token")
            return
        }

        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase authentication failed with error: \(error.localizedDescription)")
            } else {
                print("User authenticated with Firebase")
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}




class FacebookAuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var signInError: Error?
    @Published var signInSuccess = false

    func signInWithFacebook(from viewController: some View) {
        isLoading = true

        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController as? UIViewController) { (result, error) in
            self.isLoading = false

            if let error = error {
                self.signInError = error
                return
            }

            guard let accessToken = AccessToken.current else {
                self.signInError = NSError(domain: "FacebookAuthViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get access token"])
                return
            }

            self.signInError = nil
//            self.signInSuccess = true

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    self.signInError = error
                    self.signInSuccess = false
                    return
                }

                guard let result = authResult else {
                    self.signInError = NSError(domain: "FacebookAuthViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error#01"])
                    self.signInSuccess = false
                    return
                }

                var photoURL = ""
                if let photo = result.user.photoURL {
                    photoURL = photo.absoluteString
                }

                let faResult = FAResult(token: AccessToken.current!.tokenString, uniqueid: result.user.uid, username: result.user.uid, email: result.user.email!, name: result.user.displayName!, avatar: photoURL, source: .facebook)

                Firestore.firestore().collection("Users").document(result.user.uid).setData([
                    "fullName": result.user.displayName,
                    "email": result.user.email,
                    "dateOfBirth": "",
                    "password": "",
                    "number": ""
                    // Add any other user data fields as needed
                ]) { error in
                    if let error = error {
                        // Handle Firestore write error
                    } else {
                        // User data saved successfully
                    }
                }



                self.signInSuccess = true
            }
        }
    }
}



enum AuthSource {
    case facebook
    // add other authentication sources here as needed
}

struct FAResult {
    let token: String
    let uniqueid: String
    let username: String
    let email: String
    let name: String
    let avatar: String
    let source: AuthSource
}
