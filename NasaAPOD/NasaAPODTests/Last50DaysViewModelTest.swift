//
//  Last50DaysViewModelTest.swift
//  NasaAPODTests
//
//  Created by Mehboob Alam on 26.12.21.
//

import XCTest
import NasaAPOD

class Last50DaysViewModelTest: XCTestCase {

    var viewModel: Last50DaysViewModel!
    var apiClient: APODAPIMock!
    
    override func setUpWithError() throws {
        apiClient = APODAPIMock(client: NetworkClientMock())
        viewModel = .init(apiClient: apiClient)
        makeDummyJson()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() throws {
        apiClient.jsonList = dummyJson
        let expectation = expectation(description: "Data test")
        viewModel.signal.subscribe(onNext: {[self] _ in
            XCTAssertEqual(viewModel.numberOfRows, 50)
            var data = viewModel.getItem(at: 0)
            XCTAssertEqual(data?.date?.getString(format: .yyyy_MM_dd) ?? "", "2021-11-07")
            XCTAssertEqual(data?.mediaType?.rawValue ?? "", "video")
            XCTAssertEqual(data?.title ?? "", "The Cat's Eye Nebula in Optical and X-ray")
            XCTAssertEqual(data?.explanation ?? "", "To some it looks like a cat's eye.")
            XCTAssertEqual(data?.url ?? "", "https://apod.nasa.gov/apod/image/2111/CatsEye_HubblePohl_960.jpg")
            XCTAssertEqual(data?.hdurl ?? "", "https://apod.nasa.gov/apod/image/2111/CatsEye_HubblePohl_1278.jpg")
            data = viewModel.getItem(at: 1)
            XCTAssertEqual(data?.mediaType?.rawValue ?? "", "image")
            viewModel.filter(forDate: "2021-11-07".getDate(format: .yyyy_MM_dd))
            XCTAssertEqual(viewModel.numberOfRows, 1)
            expectation.fulfill()
        }, onError: {error in
            XCTFail()
            expectation.fulfill()
        })
        viewModel.sendRequestForLast50Images()
        waitForExpectations(timeout: 20, handler: nil)
    }

    func testMediaType() throws {
        XCTAssertEqual(MediaType.video.rawValue, "video")
        XCTAssertEqual(MediaType.image.rawValue, "image")
    }

    var dummyJson: [[String: Any]]!
    func makeDummyJson() {
        let list = Array(repeating: [
            "copyright":"Martin Lefranc",
            "date":"2021-11-06",
            "explanation":"On an August night two friends enjoyed.",
            "hdurl":"https://apod.nasa.gov/apod/image/2111/panohugoetmoiAPODjpg-standard2048.jpg",
            "media_type":"image",
            "service_version":"v1",
            "title":"The Galaxy Between Two Friends",
            "url":"https://apod.nasa.gov/apod/image/2111/panohugoetmoiAPODjpg-standard1024.jpg"
         ], count: 48)
        dummyJson = [[
            "date":"2021-11-07",
            "explanation":"To some it looks like a cat's eye.",
            "hdurl":"https://apod.nasa.gov/apod/image/2111/CatsEye_HubblePohl_1278.jpg",
            "media_type":"video",
            "service_version":"v1",
            "title":"The Cat's Eye Nebula in Optical and X-ray",
            "url":"https://apod.nasa.gov/apod/image/2111/CatsEye_HubblePohl_960.jpg"
         ],
         [
            "copyright":"St00e9phane Poirier",
            "date":"2021-11-08",
            "explanation":"Why, sometimes, does part of the Sun's atmosphere leap into space? The reason lies in changing magnetic fields that thread through the Sun's surface.",
            "media_type":"image",
            "service_version":"v1",
            "thumbnail_url":"https://img.youtube.com/vi/7NykS2kv_k8/0.jpg",
            "title":"A Filament Leaps from the Sun",
            "url":"https://www.youtube.com/embed/7NykS2kv_k8?playlist=7NykS2kv_k8&loop=1;rel=0&autoplay=1"
         ]] + list
    }
}
