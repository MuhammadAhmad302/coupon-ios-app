//
//  ResetOtpScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-09.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct ResetOtpScreen: View {

    @ObservedObject var otpModel: OTPModel = .init()
    @FocusState var activeFeild: OTPFeild?
    @Binding var codeId: String
    @Binding var phoneNumber: String
    @State var shouldNavigate = false
    @Binding var email: String
    @Binding var password: String
    @State var alert = false
    @State var error = ""
    @State private var isLoading = false
    @Binding var isSignup: Bool

    @ViewBuilder
    func destinationSelector() -> some View {
        if (isSignup) {
            CreateAccountPopUpScreenswift()
        }
        else {
            ResetPasswordScreen()
        }
    }

    var body: some View {
        GeometryReader { bounds in
            ZStack {
                VStack {
                    NavigationLink(destination: destinationSelector(), isActive: $shouldNavigate, label: { EmptyView()})
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "forgetPassword"))
                        .padding(.bottom, 20)
                        .padding(.horizontal, 10)
                    VStack(alignment: .leading, spacing: 20) {
                        otpSection(bounds: bounds)
                        sendOtpButton(bounds: bounds)
                    }
                    .padding(.horizontal, 10)
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
        }
    }

    func sendOtpButton(bounds: GeometryProxy) -> some View {
        Button {
            checkOtp()
        } label: {
            PrimaryButton(btnWidth: .infinity, btnText: translate(key: "resetBtn"), color: Color(hex: 0x49425E), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.top, 20)
    }

    func checkOtp() {
        let verificationCode = otpModel.otpFeilds.joined()
        self.isLoading = true
        let crediential =
        PhoneAuthProvider.provider().credential(withVerificationID: self.codeId, verificationCode: verificationCode)
        print(crediential)


        Auth.auth().signIn(with: crediential) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                // handle the error as needed
                self.error =  error.localizedDescription
                self.alert.toggle()
                return
            } else {
                print("phone auth successfully")
            }

            Auth.auth().signIn(withEmail: email, password: password) { res, err in
                if err != nil {
                    self.error =  err!.localizedDescription
                    self.alert.toggle()
                    print(err!.localizedDescription)
                } else {
                    print("Successfully Login")
                    if !isSignup {
                        isLoading = false
                        shouldNavigate = true
                    }
                    if isSignup {
                        guard let user = Auth.auth().currentUser else { return }
                        print(user.isEmailVerified)
                        user.sendEmailVerification { error in
                            if let error = error {
                                print("Error sending verification email: \(error.localizedDescription)")
                            } else {
                                print("Verification email sent.")
                                checkEmailVerification()
                            }
                        }
                    }
                }
            }

            // if there is no error, the user has successfully signed in
            print("Successfully signed in")
        }
    }

    func otpSection(bounds: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(translate(key: "resetPassword"))
                .font(.system(size: 27, weight: .semibold))
            Text(translate(key: "enterCodeDiscription"))
                .font(.system(size: 18, weight: .medium))
            OTPFeild()
                .font(.system(size: bounds.size.width > breakPoint ? 35 : 20))
                .onChange(of: otpModel.otpFeilds) { newValue in
                    OTPCondition(value: newValue)
                }
            HStack(spacing: 20) {
                Spacer()
                Text(translate(key: "dontReceiveCode"))
                Button {

                } label: {
                    Text(translate(key: "resendAgain"))
                        .foregroundColor(Color(hex: 0x22A45D))
                }
                .buttonStyle(NoAnim())
                Spacer()
            }
        }
    }

    func OTPCondition(value: [String]) {

        // Moving to next field if current field is filled with a single digit
        for index in 0..<6 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeFeild && !(index == 5 && value[index].count == 1) {
                activeFeild = activeStateForIndex(index: index + 1)
            }
        }

        // Moving back to previous field if current field is empty and previous field is not empty
        for index in 1...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeFeild = activeStateForIndex(index: index - 1)
            }
        }

        // Updating the OTP model with the last digit of any field that has more than one digit
        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpFeilds[index] = String(value[index].last!)
            }
        }
    }

    func checkEmailVerification() {
        guard let user = Auth.auth().currentUser else { return }
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            user.reload { error in
                if let error = error {
                    print("Error reloading user: \(error.localizedDescription)")
                } else {
                    if user.isEmailVerified {
                        // Navigate to the desired view
                        isLoading = false
                        shouldNavigate = true
                    }
                }
            }
        }

        timer.fire()
    }

    @ViewBuilder
    func OTPFeild() -> some View {
        HStack {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: $otpModel.otpFeilds[index])
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .multilineTextAlignment(.center)
                    .focused($activeFeild, equals: activeStateForIndex(index: index))
                    .frame(height: 80)
                    .background(Color(hex: 0xfafafa))
                    .cornerRadius(10)
            }
        }
    }

    func activeStateForIndex(index: Int) -> OTPFeild {
        switch index {
        case 0 : return .feild1
        case 1 : return .feild2
        case 2 : return .feild3
        case 3 : return .feild4
        case 4 : return .feild5
        case 5 : return .feild6
        default: return .feild6
        }
    }

    func requestOtp() {
        let phNo = phoneNumber
        PhoneAuthProvider.provider().verifyPhoneNumber(phNo, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                self.error = error.localizedDescription
                self.alert.toggle()
                return
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
    }

}

enum OTPFeild {
    case feild1
    case feild2
    case feild3
    case feild4
    case feild5
    case feild6
}
