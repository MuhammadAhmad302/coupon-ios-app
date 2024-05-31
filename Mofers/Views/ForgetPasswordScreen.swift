//
//  ForgetPasswordScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-08.
//

import SwiftUI
import Firebase

struct ForgetPasswordScreen: View {
    
    @State var phoneNumber = ""
    @State var code: String = ""
    @State var id = ""
    @State var move = false
    @State var shouldNavigate = false
    @State var email = ""
    @State var password = ""
    @State var alert = false
    @State var error = ""
    @State var isSignup = false
    @State private var isLoading = false


    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                NavigationLink(destination: ResetOtpScreen(codeId: $id, phoneNumber: $phoneNumber, email: $email, password: $password, isSignup: $isSignup), isActive: $shouldNavigate, label: { EmptyView()})
                VStack(spacing: 50) {
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "forgetPassword"))
                    VStack(alignment: .leading, spacing: 20) {
                        detailSection(bounds: bounds)
                        resetPasswordButton(bounds: bounds)
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
            .navigationBarHidden(true)
            .padding(.horizontal, 10)
        }
    }

    func detailSection(bounds: GeometryProxy) -> some View {
        return
        VStack(alignment: .leading, spacing: 20) {
            Text(translate(key: "forgetPassword"))
                .font(.system(size: 27, weight: .semibold))
            Text(translate(key: "enterNumberDiscription"))
                .font(.system(size: 18, weight: .medium))
            CustomSecureFeild(title: translate(key: "addNumber"), width: .infinity, height: bounds.size.width, controller: $phoneNumber, icon: "iphone.gen2", fontSize: bounds.size.width, keyboardType: .namePhonePad)
        }
    }

    func resetPasswordButton(bounds: GeometryProxy) -> some View {
        Button {
            async {
                await verifyUserExists()
            }
        } label: {
            //                            NavigationLink(destination: ResetOtpScreen(codeId: $id), isActive: $move) {
            PrimaryButton(btnWidth: .infinity, btnText: translate(key: "resetPassword"), color: Color(hex: 0x49425E), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
                .padding(.top, 20)
            //                        }
        }
        .buttonStyle(PlainButtonStyle())
    }

    func verifyUserExists() async {
        self.isLoading = true
        let db = Firestore.firestore()
        let userRef = db.collection("Users").whereField("number", isEqualTo: phoneNumber)

        do {
            let querySnapshot = try await userRef.getDocuments()
            if let document = querySnapshot.documents.first {
                let data = document.data()
                guard let email = data["email"] as? String, let password = data["password"] as? String else {
                    print("User's email or password not found")
                    return
                }
                self.email = email
                self.password = password

                try await verifyPhoneNumber()
            } else {
                print("User not found in Firestore")
                self.error = "User not found please enter valid number"
                self.alert.toggle()
            }
        } catch {
            print("Error getting user document: \(error.localizedDescription)")
        }
    }

    func verifyPhoneNumber() async {
        do {
            let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.phoneNumber, uiDelegate: nil) {  res, err in
                if err != nil {
                    self.error =  err!.localizedDescription
                    self.alert.toggle()
                    print(err?.localizedDescription)
                } else {
                    self.id = res!
                    self.isLoading = false
                    self.shouldNavigate = true
                    // Handle successful phone number verification
                    // ...
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}

struct ForgetPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordScreen()
    }
}
