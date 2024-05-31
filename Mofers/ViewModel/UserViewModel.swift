////
////  UserViewModel.swift
////  Mofers
////
////  Created by Rashdan Natiq on 2023-03-31.
////
//
//
import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
//import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    // MARK: State
    @Published var user: _User?

    // MARK: Properties
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    var uuid: String? {
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && self.userIsAuthenticated
    }

    // MARK: Firebase Auth Functions
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            // Successfully authenticated the user, now attempting to sync with Firestore
            DispatchQueue.main.async {
                self?.sync()
            }

        }
    }

    func signUp(fullName: String, email: String, dateOfBirth: String, password: String, phoneNumber: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            DispatchQueue.main.async {
                self?.add(_User(fullName: fullName, email: email, dateOfBirth: dateOfBirth, password: password, phoneNumber: phoneNumber))
                self?.sync()
            }
        }
    }


    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
        } catch {
            print("Error signing out the user: \(error)")
        }
    }

    // Firestore functions for User Data
    private func sync() {
        guard userIsAuthenticated else { return }
        db.collection("Users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else { return }
            do {
                if let userData = document!.data() as? [String: Any] {
                    self.user = _User(data: userData)
                } else {
                    print("Error: document does not contain valid user data")
                }
            } catch {
                print("Sync error: \(error)")
            }
        }
    }

//    private func sync() {
//                guard userIsAuthenticated else { return }
//                db.collection("Users").document(self.uuid!).getDocument { (document, error) in
//                    guard document != nil, error == nil else { return }
//                    do {
//                        try self.user = document!.data(as: User?.self)
//                    } catch {
//                        print("Sync error: \(error)")
//                    }
//                }
//            }



    private func add(_ user: _User) {
        guard userIsAuthenticated else {
            return
        }
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(
                [
                    "fullName": user.fullName,
                    "email": user.email,
                    "dateOfBirth": user.dateOfBirth,
                    "password": user.password
                ]
            )
            //            let userDict =
        } catch {
            print("Error adding: \(error)")
        }
    }

    private func update() {
        guard userIsAuthenticatedAndSynced else {
            return
        }
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(
                [
                    "fullName": user?.fullName,
                    "dateOfBirth": user?.dateOfBirth
                ])
        } catch {
            print("Error updating: \(error)")
        }
    }
}


struct ErrorView : View {

    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    var width: CGFloat

    var body: some View{
        VStack {
            HStack{

                Text(self.error == "RESET" ? "Message" : "Error")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(self.color)
            }
            .padding(.horizontal, 25)

            Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                .multilineTextAlignment(.center)
                .foregroundColor(self.color)
                .padding(.top)
                .padding(.horizontal, 25)

            Button(action: {

                self.alert.toggle()

            }) {

                Text(self.error == "RESET" ? "Ok" : "Cancel")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: width * 0.5)
            }
            .background(Color(hex: 0x49425E))
            .cornerRadius(10)
            .padding(.top, 25)
        }
        .padding(.vertical, 25)
        .frame(width: width * 0.8)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
    }
}
