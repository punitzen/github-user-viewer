//
//  GitUserViewerTests.swift
//  GitUserViewerTests
//
//  Created by Punit Kumar on 09/08/22.
//

import XCTest
@testable import GitUserViewer

class UtilitiesTest: XCTestCase {
    
    var dateUtility: DateUtility?
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let date = dateFormatter.date(from: "2022-08-17T07:25:11Z")
        dateUtility = DateUtility(date: date ?? Date())
    }
    
    override func tearDown() {
        dateUtility = nil
    }
    
    func testRoundOffUtility() {
        let test1 = RoundNumberUtility.roundedWithAbbreviations(100_000)
        XCTAssertEqual(test1, "100K")
        
        let test2 = RoundNumberUtility.roundedWithAbbreviations(235_7687_986)
        XCTAssertEqual(test2, "2.3B")
        
        let test3 = RoundNumberUtility.roundedWithAbbreviations(4579_686)
        XCTAssertEqual(test3, "4.5M")
    }
    
    func testDateUtility() {
        let test1 = dateUtility?.timeDateDifference(repoDate: "2020-02-19T07:25:11Z")
        XCTAssertEqual(test1, "last updated 2 years ago")
        
        let test2 = dateUtility?.timeDateDifference(repoDate: "2022-05-01T10:51:20Z")
        XCTAssertEqual(test2, "last updated 3 months ago")
        
        let test3 = dateUtility?.timeDateDifference(repoDate: "2022-08-04T10:34:15Z")
        XCTAssertEqual(test3, "last updated a week ago")
        
        let test4 = dateUtility?.timeDateDifference(repoDate: "2022-08-13T09:34:15Z")
        XCTAssertEqual(test4, "last updated 3 days ago")
        
        let test5 = dateUtility?.timeDateDifference(repoDate: "2022-08-17T04:34:15Z")
        XCTAssertEqual(test5, "last updated 2 hours ago")
        
        let test6 = dateUtility?.timeDateDifference(repoDate: "2022-08-17T07:20:00Z")
        XCTAssertEqual(test6, "last updated 5 minutes ago")
        
        let test7 = dateUtility?.timeDateDifference(repoDate: "2022-08-17T07:25:09Z")
        XCTAssertEqual(test7, "last updated 2 seconds ago")
    }
}
