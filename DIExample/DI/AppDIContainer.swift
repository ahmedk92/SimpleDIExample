//
//  AppDIContainer.swift
//  DIExample
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

import FirebaseAuth

class AppDIContainer {
    func makeAuthenticationService() -> AuthenticationService {
        DefaultAuthenticationService(firebaseAuth: Auth.auth())
    }
}
