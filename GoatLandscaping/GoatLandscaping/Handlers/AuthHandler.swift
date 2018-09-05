//
//  AuthHandler.swift
//  GoatLandscaping
//
//  Created by Jen Person on 8/13/18.
//  Copyright © 2018 Jen Person. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI

var isUser = false


class AuthHandler: NSObject, FUIAuthDelegate {
  
  var authUI: FUIAuth?
  var user: User?
  
  override init() {
    authUI = FUIAuth.defaultAuthUI()
    let providers: [FUIAuthProvider] = [
      FUIGoogleAuth(),
      ]
    self.authUI?.providers = providers
  }
  
  func checkLoginStatus(completion: @escaping (User?) -> Void) {
    Auth.auth().addStateDidChangeListener { auth, user in
        completion(Auth.auth().currentUser)
    }
  }
  
  
  func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
    // handle user and error as necessary
  }
  
  func signIn() {
    let authViewController = self.authUI!.authViewController()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController?.present(authViewController, animated: true, completion: nil)
  }
  
  func signOut() {
    do {
      try self.authUI!.signOut()
    } catch {
      print("unable to logout")
    }
  }
}

