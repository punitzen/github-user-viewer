//
//  UserViewModalTest.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 10/08/22.
//

import XCTest
@testable import GitUserViewer

class UserViewModalForUserTest: XCTestCase, UserViewModalDelegate {
    
    var userViewModal: UserViewModal?
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        expectation = nil
        let apiFetch = MockData()
        userViewModal = UserViewModal(apiFetch: apiFetch)
        userViewModal?.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        userViewModal = nil
        expectation = nil
    }
    
    func testFetchUser() {
        expectation = self.expectation(description: "testing fetch user with correct response")
        userViewModal?.fetchUser(userName: "CorrectUser")
        waitForExpectations(timeout: 5)
    }
    
    func testFetchUserWithError() {
        expectation = self.expectation(description: "testing fetch user with error in response")
        userViewModal?.fetchUser(userName: "IncorrectUser")
        waitForExpectations(timeout: 5)
    }
    
    func updateUI() {
        XCTAssertNotNil(userViewModal?.userModal)
        XCTAssertNotNil(userViewModal?.userModal?.login)
        XCTAssertEqual(userViewModal?.userCollectionDataCount, [67,11,43])
        expectation?.fulfill()
    }
    
    func couldNotFetchUser() {
        XCTAssertNil(userViewModal?.userModal)
        XCTAssertTrue((userViewModal?.userCollectionDataCount.isEmpty) == true)
        expectation?.fulfill()
    }
    
    func reloadTable() {}
    
    func couldNotFetchRepo() {}
}


class UserViewModalForRepoTest: XCTestCase, UserViewModalDelegate {
    
    var userViewModal: UserViewModal?
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        expectation = nil
        let apiFetch = MockData()
        userViewModal = UserViewModal(apiFetch: apiFetch)
        userViewModal?.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        userViewModal = nil
        expectation = nil
    }
    
    func testFetchRepo() {
        expectation = self.expectation(description: "testing fetch repository with correct response")
        userViewModal?.fetchUserRepo(userName: "CorrectRepo")
        waitForExpectations(timeout: 5)
    }
    
    func testFetchRepoWithError() {
        expectation = self.expectation(description: "testing fetch repository with error in response")
        userViewModal?.fetchUserRepo(userName: "IncorrectRepo")
        waitForExpectations(timeout: 5)
    }
    
    func reloadTable() {
        XCTAssertTrue((userViewModal?.userRepoModal?.isEmpty) == false)
        expectation?.fulfill()
    }
    
    func couldNotFetchRepo() {
        XCTAssertTrue((userViewModal?.userRepoModal?.isEmpty) == true)
        expectation?.fulfill()
    }
    
    func updateUI() {}
    
    func couldNotFetchUser() {}
}
