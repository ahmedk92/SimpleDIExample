//
//  FirebaseAuthProtocol.swift
//  DIExample
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

import FirebaseAuth

protocol FirebaseAuthProtocol {
    func login(
        withEmail email: String,
        password: String,
        completion: @escaping ((Result<Any, Error>) -> Void)
    )
}

extension Auth: FirebaseAuthProtocol {
    func login(
        withEmail email: String,
        password: String,
        completion: @escaping ((Result<Any, Error>) -> Void)
    ) {
        signIn(withEmail: email, password: password) { (data, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                fatalError("Nonesense. There was no error nor data.")
            }
        }
    }
}
