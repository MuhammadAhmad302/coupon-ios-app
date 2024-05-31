//
//  AddPhoneNumberScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-08.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import _AuthenticationServices_SwiftUI

struct AddPhoneNumberScreen: View {

    // MARK: - Properties

    @Binding var userName: String
    @Binding var email: String
    @Binding var dateOfBirth: String
    @Binding var password: String

    // MARK: - States

    @State private var id = ""
    @State private var alert = false
    @State private var error = ""
    @State private var isLoading = false
    @State private var phoneNumber = ""
    @State private var shouldNavigate = false
    @State private var isSignup = true
    @State private var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    // MARK: - Observables

    @ObservedObject var phoneAuth = PhoneAuth()

    // MARK: - Computed Properties

    private var uuid: String? {
        Auth.auth().currentUser?.uid
    }

    // MARK: - View
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                NavigationLink(destination: ResetOtpScreen(codeId: $id, phoneNumber: $phoneNumber, email: $email, password: $password, isSignup: $isSignup), isActive: $shouldNavigate, label: { EmptyView()})
                VStack(spacing: 50) {
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "signup"))
                    VStack(alignment: .leading, spacing: 20) {
                        Text(translate(key: "addMobile"))
                            .font(.system(size: 27, weight: .semibold))
                        Text(translate(key: "addNumberDiscription"))
                            .font(.system(size: 18, weight: .medium))
                        CustomSecureFeild(title: translate(key: "phoneNumber"), width: .infinity, controller: $phoneNumber, icon: "iphone.gen2", fontSize: bounds.size.width, keyboardType: .namePhonePad)
                        addNumber(bounds: bounds)
                    }
                    Spacer()
                }
                
                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error, width: bounds.size.width)
                }

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                }
            }
            .padding(.horizontal, 10)
            .navigationBarHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
            }
        }
    }

     func addNumber(bounds: GeometryProxy) -> some View {
        Button {
            async {
                await verifyPhoneNumber()
            }
        } label: {
            PrimaryButton(btnWidth: .infinity, btnText: translate(key: "addNumber"), color: Color(hex: 0x49425E), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
                .padding(.top, 20)
        }
    }

    func verifyPhoneNumber() async {
        self.isLoading =  true
        do {
            let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.phoneNumber, uiDelegate: nil) {  res, err in
                if err != nil {
                    self.error =  err!.localizedDescription
                    self.alert.toggle()
                    print(err?.localizedDescription)
                } else {
                    do {
                        let _ = try Firestore.firestore().collection("Users").document(self.uuid!).setData(
                            [
                                "fullName": userName,
                                "email": email,
                                "dateOfBirth": dateOfBirth,
                                "password": password
                            ]
                        )
                        self.isLoading =  false
                        shouldNavigate = true
                    } catch {
                        shouldNavigate = false
                        print("Error adding: \(error)")
                    }
                    self.id = res!
                    // Handle successful phone number verification
                    // ...
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    class PhoneAuth: ObservableObject {
        @Published var phNo = ""
        @Published var code = ""

        func getCountryCode() -> String {
            let regionCode = Locale.current.regionCode ?? ""
            return regionCode
        }

        func sendCode() {

            Auth.auth().settings?.isAppVerificationDisabledForTesting = true

            let number = "+\(getCountryCode())\(phNo)"

            PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { CODE, err in
                if let error = err {
                    print("Not verified number\(err!.localizedDescription)")
                    return
                }
                self.code = CODE ?? ""
            }
        }


        func verifyCode() {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.code, verificationCode: code)
            Auth.auth().signIn(with: credential) { (result, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
            }
        }

    }
}




