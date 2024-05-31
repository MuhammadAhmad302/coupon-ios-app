//
//  LoginScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-08.
//

import SwiftUI
import Firebase
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn


struct LoginScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "ar"
    @AppStorage("log_State") var log_State = false
    var signinViewModel = SignIn_WithAppleButton()
    @State var alert = false
    @State var error = ""
    @State var phoneNumber = ""
    @State var password = ""
    @State var isVisible: Bool = false
    @State private var isLoading = false
    @State private var shouldNavigate = false

    var screenSize: CGRect {
        UIScreen.main.bounds
    }

    
    var body: some View {
        ZStack {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    headerView()
                    CustomSecureFeild(title: translate(key: "emailAddress"), width: .infinity, controller: $phoneNumber, icon: "iphone.gen2", fontSize: screenSize.width, keyboardType: .emailAddress)
                    textFeildView()
                    loginSection()
                    SocialIcons(width: screenSize.width)
                    bottomView()
                }
                .padding(15)
                .background(.white)
                .cornerRadius(15)
                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error, width: screenSize.width)
                }

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                }
            }
            .frame(height: screenSize.height * 0.5)
            .padding(20)
            .environment(\.locale, .init(identifier: selectedLanguage))
            .environment(\.layoutDirection, selectedLanguage  == "ar" ? .rightToLeft : .leftToRight)
        }
        .frame(width: screenSize.width, height: screenSize.height)
        .background(Color.black.opacity(0.4))
        .ignoresSafeArea(.all)
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
    }
    
    
    func verify() {
        
        if self.phoneNumber != "" && self.password != ""{
            isLoading = true
            if password.count >= 6 {
                Auth.auth().signIn(withEmail: self.phoneNumber, password: self.password) { (res, err) in
                    isLoading = false
                    if err != nil{
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    } else {
                        self.password = ""
                        self.phoneNumber = ""

                        guard let user = Auth.auth().currentUser else {
                            return
                        }

                        
                        let db = Firestore.firestore()
                        let usersRef = db.collection("Users")
                        let userRef = usersRef.document(user.uid)

                        userRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                let data = document.data()
                                let name = data?["fullName"] as? String ?? ""
                                let email = data?["email"] as? String ?? ""

                                if let name = data?["fullName"] as? String {
                                    let changeRequest = user.createProfileChangeRequest()
                                    changeRequest.displayName = name
                                    changeRequest.commitChanges { error in
                                        if let error = error {
                                            print("Error updating display name: \(error.localizedDescription)")
                                        } else {
                                            print("Display name updated successfully")
                                        }
                                    }
                                }

                                print(name)
                                UserDefaults.standard.set(name, forKey: "fullName")
                                // Do something with the user data, such as update your app's UI
                            } else {
                                print("User document does not exist")
                            }
                        }
                        print("success")
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        shouldNavigate = true
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                    }
                }
            } else {
                isLoading = false
                shouldNavigate = false
                self.error = "Please enter correct and complete password"
                self.alert.toggle()
            }
        }
        else{
            isLoading = false
            shouldNavigate = false
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }

    struct LoginTextFields: View {

        @State var phoneNumber = ""
        @State var password = ""
        @State var isVisible: Bool = false
        var width: CGFloat
        @State var alert = false
        @State var error = ""
        var controller: Binding<String>
        var placeHolder: LocalizedStringKey


        var body: some View {
            VStack {
                CustomSecureFeild(title: translate(key: "mobileNumber"), width: .infinity, controller: $phoneNumber, icon: "iphone.gen2", fontSize: width)
                HStack {
                    if self.isVisible {
                        TextField(translate(key: "password"), text: controller)
                            .font(.system(size: width / 30))
                            .padding(.leading, 20)
                            .frame(height: width / 10)
                    } else {
                        SecureField(translate(key: "password"), text: controller)
                            .font(.system(size: width / 30))
                            .padding(.leading, 20)
                            .frame(height: width / 10)
                    }
                    Button {
                        self.isVisible.toggle()
                    } label: {
                        Image(systemName: self.isVisible ? "eye.fill" : "eye.slash.fill")
                            .font(.system(size: width / 30))
                    }
                    .buttonStyle(NoAnim())
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
            }
            .frame(maxWidth: .infinity)
        }
    }

    func headerView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(translate(key: "helloThere"))
                .font(.system(size: screenSize.width > breakPoint ? 33 : 22, weight: .bold))
            Text(translate(key: "enterPhoneNumber"))
                .foregroundColor(.gray)
                .font(.system(size: screenSize.width > breakPoint ? 28 : 18, weight: .regular))

            HStack {
                Text(translate(key: "to_login_Or"))
                    .foregroundColor(.gray)
                    .font(.system(size: screenSize.width > breakPoint ? 28 : 18, weight: .regular))
                Button {

                } label: {
                    NavigationLink(destination: SignUpScreen()) {
                        VStack(spacing: 0) {
                            Text(translate(key: "Create_new_account"))
                                .foregroundColor(Color(hex: 0x49425E))
                                .font(.system(size: screenSize.width > breakPoint ? 28 : 18, weight: .regular))
                                .background(
                                    Rectangle()
                                        .foregroundColor(Color(hex: 0x49425E))
                                        .frame(height: screenSize.width > breakPoint ? 4 : 2)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .offset(y: 15)
                                )
                        }
                        .frame(minWidth: 200, maxWidth: 250)
                    }
                }
                .buttonStyle(NoAnim())
            }
        }
    }

    func textFeildView() -> some View {
        HStack {
            if self.isVisible {
                TextField(translate(key: "password"), text: $password)
                    .font(.system(size: screenSize.width / 30))
                    .padding(.leading, 20)
                    .frame(height: screenSize.width / 10)
            } else {
                SecureField(translate(key: "password"), text: $password)
                    .font(.system(size: screenSize.width / 30))
                    .padding(.leading, 20)
                    .frame(height: screenSize.width / 10)
            }

            Button {
                self.isVisible.toggle()
            } label: {
                Image(systemName: self.isVisible ? "eye.fill" : "eye.slash.fill")
                    .font(.system(size: screenSize.width / 30))
            }
            .buttonStyle(NoAnim())
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)

    }

    func loginSection() -> some View {
        return
        VStack {
            Button {
                self.verify()
            } label: {
                ZStack {
                    PrimaryButton(btnWidth: .infinity,btnText: translate(key: "login"), color: Color(hex: 0x49405F), width: screenSize.width, height: screenSize.width > breakPoint ? 80 : 50)
                }
            }
            .buttonStyle(NoAnim())

            HStack {
                Spacer()
                Text(translate(key: "or"))
                    .font(.system(size: screenSize.width > breakPoint ? 26 : 16, weight: .medium))
                Spacer()
            }

            ZStack {
                SignInWithAppleButton(onRequest: { request in
                    signinViewModel.SigninWithAppleRequest(request)
                }, onCompletion: { result in
                    signinViewModel.SigninWithAppleCompletion(result)
                })
            }
            .frame(height: screenSize.width > breakPoint ? 90 : 50)
            .frame(minWidth: 0,maxWidth: .infinity)
        }
    }

    func bottomView() -> some View {
        return
        VStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text(translate(key: "cancel"))
                    .foregroundColor(Color(hex: 0x9D9D9D))
                    .font(.system(size: screenSize.width > breakPoint ? 26 : 16, weight: .semibold))
                    .frame(height: 50)
            }
            .buttonStyle(NoAnim())
            .frame(height: screenSize.width > breakPoint ? 80 : 50)
            .frame(maxWidth: .infinity)
            .background(Color(hex: 0xEAEAEA))
            .cornerRadius(10)
            Button {

            } label: {
                NavigationLink(destination: ForgetPasswordScreen()) {
                    HStack {
                        Spacer()
                        Text(translate(key: "forgetPassword"))
                            .foregroundColor(.black)
                            .font(.system(size: screenSize.width > breakPoint ? 25 : 15))
                        Spacer()
                    }
                }
            }
            .buttonStyle(NoAnim())
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}


