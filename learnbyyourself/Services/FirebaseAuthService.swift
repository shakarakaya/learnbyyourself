//
//  FirebaseAuthService.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import UIKit

protocol AuthServiceProtocol {
    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)

}

final class FirebaseAuthService: AuthServiceProtocol {
    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("❌ clientID not found")
            return
        }

        let config = GIDConfiguration(clientID: clientID)


        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let user = result?.user,
                    let idToken = user.idToken?.tokenString else {
                print("❌ Missing Google user data")
                return
            }
                
            let accessToken = user.accessToken.tokenString


            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign-in error: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                print("✅ Firebase sign-in success: \(authResult?.user.uid ?? "Unknown UID")")
                completion(.success(()))
                
            }
        }
}
    

    
    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

