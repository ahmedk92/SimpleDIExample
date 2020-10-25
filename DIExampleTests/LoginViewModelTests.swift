//
//  LoginViewModelTests.swift
//  DIExampleTests
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

import XCTest
@testable import DIExample

class LoginViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        authenticationService = .init()
        sut = .init(authenticationService: authenticationService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        authenticationService = nil
    }

    func test_login_failure() throws {
        // Given
        enum DummyError: Error { case error1 }
        let expectedError = DummyError.error1
        authenticationService.result = .failure(expectedError)
        var errorToTest: DummyError?
        sut.showError = { error in
            errorToTest = expectedError
        }
        // When
        sut.login(
            withEmail: "",
            password: "")
        // Then
        XCTAssertEqual(errorToTest, expectedError)
    }
    
    func test_login_success() {
        // Given
        let expectedUser = User(data: "")
        authenticationService.result = .success(expectedUser)
        var userToTest: User?
        sut.showMainViewForUser = { user in
            userToTest = user
        }
        // When
        sut.login(
            withEmail: "",
            password: "")
        // Then
        XCTAssertEqual(userToTest, expectedUser)
    }
    
    // sut = system under test
    private var sut: LoginViewModel!
    private var authenticationService: AuthenticationServiceMock!
    private class AuthenticationServiceMock: AuthenticationService {
        var result: Result<User, Error>!
        func login(
            withEmail email: String,
            password: String,
            completion: @escaping ((Result<User, Error>) -> Void)
        ) {
            completion(result)
        }
    }
}
