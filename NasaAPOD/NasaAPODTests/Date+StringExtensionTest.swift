//
//  Date+StringExtensionTest.swift
//  NasaAPODTests
//
//  Created by Mehboob Alam on 26.12.21.
//
import NasaAPOD
import XCTest

class Date_StringExtensionTest: XCTestCase {

    func testDates() throws {
        let dateSTR = "2021-10-20"
        XCTAssertEqual(dateSTR.changeDateFormat(fromFromat: .yyyy_MM_dd, toFormat: .dd_MMM_yyyy), "20 Oct, 2021")
        XCTAssertEqual(DateFormat.hhmm_a.rawValue, "h:mm a")
        // get string and get date methods were checked already in VMS, no need to duplicate the test.
    }
}
