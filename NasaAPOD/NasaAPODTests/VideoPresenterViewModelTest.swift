//
//  VideoPresenterViewTest.swift
//  NasaAPODTests
//
//  Created by Mehboob Alam on 26.12.21.
//

import XCTest
import NasaAPOD

class VideoPresenterViewModelTest: XCTestCase {

    var model: VideoViewModel!

    override func setUpWithError() throws {
        model = VideoViewModel(url: "https://www.youtube.com/embed/25FfQ9MEQE8")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVewModel() throws {
        XCTAssert(model.isYoutube)
        XCTAssertEqual(model.lastPathComponent, "25FfQ9MEQE8")
        XCTAssertEqual(model.url?.absoluteString, "https://www.youtube.com/embed/25FfQ9MEQE8")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
