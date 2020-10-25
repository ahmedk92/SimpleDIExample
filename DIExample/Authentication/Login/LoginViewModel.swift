//
//  LoginViewModel.swift
//  DIExample
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

class LoginViewModel {
    // MARK: API
    init(
        authenticationService: AuthenticationService = AppDIContainer().makeAuthenticationService()
    ) {
        self.authenticationService = authenticationService
    }
    func login(
        withEmail email: String,
        password: String
    ) {
        authenticationService.login(
            withEmail: email,
            password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.showError?(error)
                case .success(let user):
                    self.showMainViewForUser?(user)
                }
            }
    }
    var showError: ((Error) -> Void)?
    var showMainViewForUser: ((User) -> Void)?
    // MARK: Implememtation
    private let authenticationService: AuthenticationService
}
