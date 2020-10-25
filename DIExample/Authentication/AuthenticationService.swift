//
//  AuthenticationService.swift
//  DIExample
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

protocol AuthenticationService: AnyObject {
    func login(
        withEmail email: String,
        password: String,
        completion: @escaping ((Result<User, Error>) -> Void)
    )
}

class DefaultAuthenticationService: AuthenticationService {
    // MARK: API
    init(firebaseAuth: FirebaseAuthProtocol) {
        self.firebaseAuth = firebaseAuth
    }
    func login(
        withEmail email: String,
        password: String,
        completion: @escaping ((Result<User, Error>) -> Void)
    ) {
        firebaseAuth.login(
            withEmail: email,
            password: password) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    completion(.success(.init(data: data)))
                }
            }
    }
    // MARK: Implementation
    private let firebaseAuth: FirebaseAuthProtocol
}
