//
//  searchViewModelTests.swift
//  NasaAPODTests
//
//  Created by Mehboob on 17/10/21.
//

import XCTest
import NasaAPOD

class SearchViewTest: XCTestCase {
    private var viewModel: SearchAPODViewModel!
    private var apiCleint: APODAPIMock!
    
    override func setUpWithError() throws {
        apiCleint = APODAPIMock(client: NetworkClientMock())
        viewModel = SearchAPODViewModel(apiCleint: apiCleint)
    }

    func testForData() {
        apiCleint.json = APODJSON
        let expectation = expectation(description: "Data test")
        viewModel.signal.subscribe(onNext: {[self] _ in
            let data = viewModel.getData()
            XCTAssertEqual(data?.date?.getString(format: .yyyy_MM_dd), "2021-10-17")
            XCTAssertEqual(data?.mediaType?.rawValue ?? "", "image")
            XCTAssertEqual(data?.title ?? "", "The Einstein Cross Gravitational Lens")
            XCTAssertEqual(data?.explanation ?? "", "Most galaxies have a single nucleus -- does this galaxy have four?")
            XCTAssertEqual(data?.url ?? "", "https://apod.nasa.gov/apod/image/2110/qso2237_wiyn_1024.jpg")
            expectation.fulfill()
        }, onError: {error in
            XCTFail()
            expectation.fulfill()
        })
        viewModel.sendRequest(date: "2021-10-17".getDate(format: .yyyy_MM_dd) ?? Date())
        waitForExpectations(timeout: 20, handler: nil)
    }

    func testApiFailure() {
        apiCleint.json = getInvalidData()
        let expectation = expectation(description: "Data test")
        viewModel.signal.subscribe(onNext: { _ in
            XCTFail()
        }, onError: { error in
            XCTAssertEqual(error.errorMessage, "Opps!!! Something went wrong")
            expectation.fulfill()
        })
        viewModel.sendRequest(date: Date())
        waitForExpectations(timeout: 20, handler: nil)
    }

    private func  getInvalidData() -> [String: Any] {
        [
            "date": "747483",
            "title": "The Einstein Cross Gravitational Lens",
            "url" : "https://apod.nasa.gov/apod/image/2110/qso2237_wiyn_1024.jpg",
            "explanation": "fghjkl;ghjkl"]
    }

    let APODJSON: [String: Any] =  [ "date": "2021-10-17",
                                     "explanation" : "Most galaxies have a single nucleus -- does this galaxy have four?",
                                     "hdurl": "https://apod.nasa.gov/apod/image/2110/qso2237_wiyn_1024.jpg",
                                     "media_type": "image",
                                     "service_version": "v1",
                                     "title": "The Einstein Cross Gravitational Lens",
                                     "url" : "https://apod.nasa.gov/apod/image/2110/qso2237_wiyn_1024.jpg"
    ]
}
