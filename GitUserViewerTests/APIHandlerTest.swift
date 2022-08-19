//
//  APIHandlerTest.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 09/08/22.
//

import XCTest
@testable import GitUserViewer

class APIHandlerTest: XCTestCase {
    
    func testFetchUserWithCorrectUsername() {
        let apiFetch = APIHandler()
        let expectation = self.expectation(description: "Response with correct username")
        
        apiFetch.fetchUser(user: "vipinhelloindia") { status, result, error in
            XCTAssertTrue(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertNil(result?.message)
            XCTAssertEqual(result?.login, "vipinhelloindia")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchUserWithIncorrectUsername() {
        let apiFetch = APIHandler()
        let expectation = self.expectation(description: "Response with Incorrect username")
        
        apiFetch.fetchUser(user: "khbfhsdbhfbshd") { status, result, error in
            XCTAssertFalse(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertEqual(result?.message, "Not Found")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
