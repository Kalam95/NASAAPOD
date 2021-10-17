//
//  DetailViewController.swift
//  NasaAPODTests
//
//  Created by Mehboob on 17/10/21.
//

import XCTest
import NasaAPOD

class DetailsViewTests: XCTestCase {
    var viewModel: APODDetailViewModel!
    
    override func setUpWithError() throws {
        let data = APODDataModel(date: "2021-10-12".getDate(format: .yyyy_MM_dd),
                                 explanation: "Testing", hdurl: "TesURlHD",
                                 mediaType: .image, url: "testURL", title: "Title")
        viewModel = APODDetailViewModel(data: data)
    }

    func testProperties() {
        XCTAssertEqual(viewModel.isFavourite, false)
        viewModel.updateDatabase()
        XCTAssertEqual(viewModel.isFavourite, true)
        XCTAssertEqual(viewModel.title, "Title")
        XCTAssertEqual(viewModel.url, "testURL")
        XCTAssertEqual(viewModel.date, "12 Oct, 2021")
        XCTAssertEqual(viewModel.type?.rawValue, "image")
        XCTAssertEqual("2021-10-12".changeDateFormat(fromFromat: .yyyy_MM_dd, toFormat: .dd_MMM_yyyy), "12 Oct, 2021")
    }
}
