//
//  ContributorsViewModalTest.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 10/08/22.
//

import XCTest
@testable import GitUserViewer

class ContributorsViewModalTest: XCTestCase, ContributorViewModalDelegate {
    
    var contributorViewModal: ContributorViewModal?
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        expectation = nil
        let apiFetch = MockData()
        contributorViewModal = ContributorViewModal(apiFetch: apiFetch)
        contributorViewModal?.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        contributorViewModal = nil
        expectation = nil
    }
    
    func testFetchContributors() {
        expectation = self.expectation(description: "testing fetch repository contributions by different users")
        contributorViewModal?.fetchContributor(userName: "CorrectContributor", repoName: "")
        waitForExpectations(timeout: 5)
    }
    
    func testFetchContributorsWithError() {
        expectation = self.expectation(description: "testing fetch repository contributions by different users with error")
        contributorViewModal?.fetchContributor(userName: "IncorrectContributor", repoName: "")
        waitForExpectations(timeout: 5)
    }
    
    func couldNotFetchContributors() {
        XCTAssertTrue((contributorViewModal?.contributorModal?.isEmpty) == true)
        expectation?.fulfill()
    }
    
    func reloadTable() {
        XCTAssertTrue((contributorViewModal?.contributorModal?.isEmpty) == false)
        expectation?.fulfill()
    }
}
