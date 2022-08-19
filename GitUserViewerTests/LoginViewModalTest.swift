//
//  LoginViewModalTest.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 10/08/22.
//

import XCTest
@testable import GitUserViewer

class LoginViewModalTest: XCTestCase, LoginViewModalDelegate {
    
    var loginViewModal: LoginViewModal?
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        expectation = nil
        let apiFetch = MockData()
        loginViewModal = LoginViewModal(apiFetch: apiFetch)
        loginViewModal?.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        loginViewModal = nil
        expectation = nil
    }
    
    func testUserWithCorrectUserName() {
        expectation = self.expectation(description: "fetching user with correct username")
        loginViewModal?.fetchUser(userName: "CorrectUser")
        waitForExpectations(timeout: 5)
    }
    
    func testUserWithIncorrectUserName() {
        expectation = self.expectation(description: "fetching user with incorrect username")
        loginViewModal?.fetchUser(userName: "UserNotFound")
        waitForExpectations(timeout: 5)
    }
    
    func testUserWithError() {
        expectation = self.expectation(description: "fetching user with error in response")
        loginViewModal?.fetchUser(userName: "IncorrectUser")
        waitForExpectations(timeout: 5)
    }
    
    func updateController() {
        XCTAssertNotNil(loginViewModal?.userModal)
        XCTAssertNotNil(loginViewModal?.userModal?.login)
        XCTAssertNil(loginViewModal?.userModal?.message)
        expectation?.fulfill()
    }
    
    func updateControllerUserNotFound() {
        XCTAssertNotNil(loginViewModal?.userModal)
        XCTAssertNil(loginViewModal?.userModal?.login)
        XCTAssertNotNil(loginViewModal?.userModal?.message)
        expectation?.fulfill()
    }
    
    func couldNotFetchData() {
        XCTAssertNil(loginViewModal?.userModal)
        expectation?.fulfill()
    }
}
