//
//  SignUpScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-06.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import _AuthenticationServices_SwiftUI
import GoogleSignIn
import FBSDKLoginKit

struct SignUpScreen: View {

    @AppStorage("log_State") var log_State = false
    @State private var contact = Contact()
    @State private var presented = false
    @State private var strHiredDate = ""
    var selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "ar"
    var signinViewModel = SignIn_WithAppleButton()
    @State private var fullName = ""
    @State var emailAddress = ""
    @State private var dateOfBirth = ""
    @State var password = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shouldNavigate = false
    @State var alert = false
    @State var error = ""
    @State var isMailValid: Bool = false
    @State private var isLoading = false
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    var uuid: String? {
        auth.currentUser?.uid
    }
    @State private var date = Date()
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var isDatePickerVisible = false
    @State private var textEditorText = ""
    @FocusState private var isTextFieldFocused: Bool
    @ObservedObject var selectDate = dataPicker()
    @StateObject var viewModel = FacebookAuthViewModel()

    @ViewBuilder
    func destinationSelector() -> some View {
        if viewModel.signInSuccess {
            // Navigate to the next screen
            CustomTabView()
        } else {
            AddPhoneNumberScreen(userName: $fullName, email: $emailAddress, dateOfBirth: $dateOfBirth, password: $password)
        }
    }

    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                VStack(spacing: 30) {
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "signup"))
                        .padding(.horizontal, 10)
                    VStack(alignment: .leading, spacing: 20) {
                        headerSection(bounds: bounds)
                        textFeildSection(bounds: bounds)
                    }
                    signUpButtonSection(bounds: bounds)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)

                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error, width: bounds.size.width)
                }

                if isLoading || signinViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                }
            }
            .environment(\.locale, .init(identifier: selectedLanguage))
            .environment(\.layoutDirection, selectedLanguage  == "ar" ? .rightToLeft : .leftToRight)
        }
        .calendarSheet(presented: $presented, value: $strHiredDate)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    struct Contact {
        var dob: Date? = nil
    }

    func register(){

        if self.emailAddress != "" && self.password != "" {
            isLoading = true
            shouldNavigate = true
            if self.password.count >= 6 {
                Auth.auth().createUser(withEmail: self.emailAddress, password: self.password) { (res, err) in

                    isLoading = false
                    shouldNavigate = false

                    if err != nil{

                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    } else {
                        do {
                            let _ = try db.collection("Users").document(self.uuid!).setData(
                                [
                                    "fullName": fullName,
                                    "email": emailAddress,
                                    "dateOfBirth": dateOfBirth,
                                    "password": password
                                ]
                            )
                            Auth.auth().signIn(withEmail: self.emailAddress, password: self.password) { (res, err) in
                                if err != nil{
                                    self.error = err!.localizedDescription
                                    self.alert.toggle()
                                    return
                                }
                            }
//                            let user = Auth.auth().currentUser
//                            if let user = user {
//                                print(user)
//                            }
                            shouldNavigate = true
                            self.fullName = ""
                            self.emailAddress = ""
                            self.dateOfBirth = ""
                            self.password = ""
//                            NavigationLink(destination: AddPhoneNumberScreen()) {
//                                EmptyView()
//                            }
                        } catch {
                            shouldNavigate = false
                            print("Error adding: \(error)")
                        }
                    }

                    print("success")
                    shouldNavigate = true

                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    self.fullName = ""
                    self.emailAddress = ""
                    self.dateOfBirth = ""
                    self.password = ""
                }
            }
            else{
                isLoading = false
                shouldNavigate = false
                self.error = "Please enter correct password"
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

    func headerSection(bounds: GeometryProxy) -> some View {
            VStack(alignment: .leading, spacing: 25) {
                Text(translate(key: "createAccount"))
                    .font(.system(size: bounds.size.width > breakPoint ? 32 : 22, weight: .bold))
                Text(translate(key: "enterEmail_password"))
                    .foregroundColor(.gray)
                    .font(.system(size: bounds.size.width > breakPoint ? 28 : 18, weight: .regular))
            }
        }

    func textFeildSection(bounds: GeometryProxy) -> some View {
         VStack(spacing: 10) {
             SignUPTextFields(width: bounds.size.width, controller: $fullName, placeHolder: "fullName")
             SignUPTextFields(width: bounds.size.width, controller: $emailAddress, placeHolder: "emailAddress", keyboardType: .emailAddress, valid: isMailValid)
             DatePickerTextField(placeholder: "Select Date", date: $contact.dob, width: bounds.size.width)
                 .padding(.leading, 20)
                 .frame(height: bounds.size.width / 10)
                 .background(Color(.secondarySystemBackground))
             SignUPTextFields(width: bounds.size.width, controller: $password, placeHolder: "password")
         }
     }

    func signUpButtonSection(bounds: GeometryProxy) -> some View {
            VStack(spacing: 10) {
                Button {
                    self.register()
                } label: {
                    ZStack {
                        PrimaryButton(btnWidth: .infinity,btnText: translate(key: "signup"), color: Color(hex: 0x49405F), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
                    }
                    .buttonStyle(NoAnim())
                }
                Text(translate(key: "signUtermsconditon"))
                    .foregroundColor(.gray)
                    .font(.system(size: bounds.size.width > breakPoint ? 22 : 12, weight: .regular))
                ZStack {
                    SignInWithAppleButton(onRequest: { request in
                        signinViewModel.SigninWithAppleRequest(request)
                    }, onCompletion: { result in
                        signinViewModel.SigninWithAppleCompletion(result)
                    })
                }
                .frame(height: bounds.size.width > breakPoint ? 90 : 50)
                .frame(minWidth: 0,maxWidth: .infinity)
                .background(.black)
                .cornerRadius(10)
                .buttonStyle(NoAnim())
                SocialIcons(width: bounds.size.width)
            }
        }

    struct SignUPTextFields: View {

        var width: CGFloat
        var controller: Binding<String>
        var placeHolder: LocalizedStringKey
        var keyboardType: UIKeyboardType = .default
        var valid: Bool = false


        var body: some View {
            VStack {
                ZStack {
                    TextField(translate(key: placeHolder), text: controller, onEditingChanged: { isEditing in
                        print(controller)
                    }, onCommit: {
                        print(controller)
                    })
                    .font(.system(size: width / 30))
                    .foregroundColor(.secondary)
                    .padding(.leading, 20)
                    .frame(height: width / 10)
                    .background(Color(.secondarySystemBackground))
                    .keyboardType(keyboardType)
                    HStack {
                        Spacer()
                        Image(systemName: valid ? "eye" : "")
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }

        private func isValidPassword(_ password: String) -> Bool {
            // minimum 6 characters long
            // 1 uppercase character
            // 1 special char

            let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")

            return passwordRegex.evaluate(with: password)
        }

        func isValidEmailAddress(emailAddressString: String) -> Bool {

            var returnValue = true
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

            do {
                let regex = try NSRegularExpression(pattern: emailRegEx)
                let nsString = emailAddressString as NSString
                let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))

                if results.count == 0
                {
                    returnValue = false
                }

            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
                returnValue = false
            }

            return  returnValue
        }

        struct LoginButtonView: UIViewRepresentable {

            func updateUIView(_ uiView: FBLoginButton, context: Context) {

            }


            typealias UIViewType = FBLoginButton

            let loginButton: FBLoginButton

            func makeUIView(context: Context) -> FBLoginButton {
                return loginButton
            }
        }

    }


}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}


struct SocialIcons: View {

    var facebookLoginManager = FacebookLoginManager()
    @StateObject var viewModel = FacebookAuthViewModel()

    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = ""
    @State var manager = LoginManager()
    var width: CGFloat
    @State var showAlert = false
    @State var shouldNavigate = false

    @ViewBuilder
    func destinationSelector() -> some View {
        if viewModel.signInSuccess {
            // Navigate to the next screen
            CustomTabView()
        } else {
            EmptyView()
        }
    }

    var body: some View {
        HStack(spacing: 20) {
            twitterButton(bounds: width)
            googleButton(bounds: width)
            facebookButton(bounds: width)
        }
    }

    func twitterButton(bounds: CGFloat) -> some View {
        Button {
            self.showAlert = true
        } label: {
            Image("twitter")
                .resizable()
                .scaledToFit()
                .frame(height: width / 15)
        }
        .buttonStyle(NoAnim())
        .padding(15)
        .frame(minWidth: 0 ,maxWidth: .infinity)
        .background(Color(hex: 0x03A9F4))
        .cornerRadius(10)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(translate(key: "rateUsAlertTitle")), message: Text(translate(key: "rateUsAlertSubTitle")), dismissButton: .cancel(Text(translate(key: "rateUsAlertAction"))))
        }
    }

    func googleButton(bounds: CGFloat) -> some View {
        Button {
            googleLogin()
        } label: {
            Text("G")
        }
        .buttonStyle(NoAnim())
        .foregroundColor(.white)
        .font(.system(size: width / 20, weight: .bold))
        .padding(15)
        .frame(minWidth: 0 ,maxWidth: .infinity)
        .background(Color(hex: 0xFF8384))
        .cornerRadius(10)
    }

    func googleLogin() {
        print("Google Login")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            guard error == nil else {
                // ...
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
                return
            }
            let userName = user.profile?.name ?? ""
            let userEmail = user.profile?.email ?? ""
            let usergivenName = user.profile?.givenName ?? ""
            let userfamilyName = user.profile?.familyName ?? ""
            let id = user.idToken?.tokenString
            print(user)

            Firestore.firestore().collection("Users").document(id!).setData([
                "fullName": userName,
                "email": userEmail,
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

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            // ...
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    return
                }
                print("google login successfully")

                guard let uid = Auth.auth().currentUser?.uid else {
                    // Handle missing user ID
                    return
                }

                guard let user = Auth.auth().currentUser else {
                    return
                }
                print(user)

                let db = Firestore.firestore()
                let usersRef = db.collection("Users")
                let userRef = usersRef.document(user.uid)

                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        let name = data?["fullName"] as? String ?? ""
                        let email = data?["email"] as? String ?? ""
                        print(name)
                        UserDefaults.standard.set(name, forKey: "fullName")
                        shouldNavigate = true
                        UserDefaults.standard.set(shouldNavigate, forKey: "shouldNavigate")


                        // Do something with the user data, such as update your app's UI
                    } else {
                        print("User document does not exist")
                    }
                }

                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                UserDefaults.standard.set(userName, forKey: "fullName")
            }
        }
    }


    func facebookButton(bounds: CGFloat) -> some View {
        Button {
            viewModel.signInWithFacebook(from: (destinationSelector()))
        } label: {
            Text("f")
        }
        .buttonStyle(NoAnim())
        .foregroundColor(.white)
        .font(.system(size: width / 20, weight: .bold))
        .padding(15)
        .frame(minWidth: 0 ,maxWidth: .infinity)
        .background(Color(hex: 0x1777D2))
        .cornerRadius(10)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(translate(key: "rateUsAlertTitle")), message: Text(translate(key: "rateUsAlertSubTitle")), dismissButton: .cancel(Text(translate(key: "rateUsAlertAction"))))
        }

    }

}




