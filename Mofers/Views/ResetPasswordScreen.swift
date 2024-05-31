//
//  ResetPasswordScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-08.
//

import SwiftUI
import Firebase


struct ResetPasswordScreen: View {
    
    @State private var password = ""
    @State var isVisible: Bool = false
    @State var shouldNavigate = false
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        NavigationLink(destination: LoginScreen(), isActive: $shouldNavigate, label: { EmptyView()})

        GeometryReader { bounds in
            ZStack {
                VStack(spacing: 50) {
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "forgetPassword"))
                    VStack(alignment: .leading, spacing: 20) {
                        headerSection(bounds: bounds)
                        changePasswordTestFeild(bounds: bounds)
                        changePasswordButton(bounds: bounds)
                        Spacer()
                    }
                }
                
                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error, width: bounds.size.width)
                }
            }
            .padding(.horizontal, 10)
            .navigationBarHidden(true)
            Spacer()
        }
    }

    func headerSection(bounds: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(translate(key: "resetPassword"))
                .font(.system(size: 27, weight: .semibold))
            Text(translate(key: "enterCodeDiscription"))
                .font(.system(size: 18, weight: .medium))
        }
    }

    func changePasswordTestFeild(bounds: GeometryProxy) -> some View {
        HStack {
            if self.isVisible {
                TextField(translate(key: "password"), text: $password)
                    .font(.system(size: bounds.size.width > breakPoint ? 35 : 18))
                    .padding(.leading, 20)
                    .frame(height: bounds.size.width > breakPoint ? 90 : 50)
            } else {
                SecureField(translate(key: "password"), text: $password)
                    .font(.system(size: bounds.size.width > breakPoint ? 35 : 18))
                    .padding(.leading, 20)
                    .frame(height: bounds.size.width > breakPoint ? 90 : 50)
            }
            Button {
                self.isVisible.toggle()
            } label: {
                Image(systemName: self.isVisible ? "eye.fill" : "eye.slash.fill")
                    .font(.system(size: bounds.size.width > breakPoint ? 30 : 20))
            }
            .buttonStyle(NoAnim())
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }

    func changePasswordButton(bounds: GeometryProxy) -> some View {
        Button {
            updatePassword()
        } label: {
            PrimaryButton(btnWidth: .infinity, btnText: translate(key: "login"), color: Color(hex: 0x49425E), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
        }
        //                    }
        .buttonStyle(PlainButtonStyle())
    }

    func updatePassword() {
        let user = Auth.auth().currentUser
        guard let uid = user?.uid else {
            // Handle error - user is not authenticated
            return
        }

        if password.count >= 6 {
            // Update the password
            Auth.auth().currentUser?.updatePassword(to: password) { error in
                if let error = error {
                    // Handle error - failed to update password
                    print(error)
                    return
                }

                // Password updated successfully - update the password in Firestore
                let db = Firestore.firestore()
                let userRef = db.collection("Users").document(uid)

                userRef.updateData([
                    "password": password
                ]) { error in
                    if let error = error {
                        // Handle error - failed to update password in Firestore
                        self.error = error.localizedDescription
                        self.alert.toggle()
                        print(error.localizedDescription)
                        return
                    }
                    print("update password")


                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        print("Logout Successfully")
                        UserDefaults.standard.removeObject(forKey: "fullName")
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }

                    // Password updated successfully in Firestore
                }
            }
        } else {
            print("password not correct")
            self.error = "Please enter correct and complete password"
            self.alert.toggle()
        }
        print("successfuully change password")
        shouldNavigate = true
    }

}


struct ResetPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordScreen()
    }
}
