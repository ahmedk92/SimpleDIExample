//
//  AuthenticationServiceTests.swift
//  DIExampleTests
//
//  Created by Ahmed Khalaf on 10/25/20.
//  Copyright © 2020 Ahmed Khalaf. All rights reserved.
//

import XCTest
@testable import DIExample

class AuthenticationServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        firebaseAuth = .init()
        sut = .init(firebaseAuth: firebaseAuth)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        firebaseAuth = nil
    }

    func test_login_failure() throws {
        // Given
        enum DummyError: Error { case error1 }
        firebaseAuth.result = .failure(DummyError.error1)
        // When
        sut.login(
            withEmail: "",
            password: "") { result in
                // Then
                switch result {
                case .failure(let error):
                    if case DummyError.error1 = error {
                        // Pass!
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
        firebaseAuth.result = .success(theUser)
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
                }
            }
    }

    
    // sut = system under test
    private var sut: DefaultAuthenticationService!
    private var firebaseAuth: FirebaseAuthMock!
    private class FirebaseAuthMock: FirebaseAuthProtocol {
        var result: Result<Any, Error>!
        func login(withEmail email: String, password: String, completion: @escaping ((Result<Any, Error>) -> Void)) {
            completion(result)
        }
    }
}
