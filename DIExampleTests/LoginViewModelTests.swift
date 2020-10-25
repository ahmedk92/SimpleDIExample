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
        authenticationService.result = .failure(DummyError.error1)
        var didShowError = false
        sut.showError = { _ in
            didShowError = true
        }
        // When
        sut.login(
            withEmail: "",
            password: "") { result in
                // Then
                switch result {
                case .failure(let error):
                    if case DummyError.error1 = error {
                        XCTAssertTrue(didShowError)
                    } else {
                        XCTFail("We have an error. But it's not our error.")
                    }
                case .success:
                    XCTFail("What user? It should fail!")
                }
            }
    }
    
    func test_login_success() {
        // Given
        let theUser = User(data: "")
        authenticationService.result = .success(theUser)
        var didShowMainView = false
        sut.showMainViewForUser = { _ in
            didShowMainView = true
        }
        // When
        sut.login(
            withEmail: "",
            password: "") { result in
                // Then
                switch result {
                case .failure:
                    XCTFail("It shouldn't fail.")
                case .success(let user):
                    XCTAssertEqual(user, theUser)
                    XCTAssertTrue(didShowMainView)
                }
            }
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
