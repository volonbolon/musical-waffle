//
//  TVShowDataModelTests.swift
//  IMDBTests
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import XCTest
@testable import IMDB

class TVShowDataModelTests: XCTestCase {
    var dataModel: TVShowDataModel!
    
    override func setUpWithError() throws {
        let client = MockAPIClient()
        dataModel = TVShowDataModel(client: client)
    }

    func testCanLoadPopularMovies() throws {
        let expectation = expectation(description: "Loads Popular TV Shows")
        let cancelable = dataModel.$shows
            .sink { shows in
                XCTAssertNotNil(shows)
                if !shows.isEmpty {
                    XCTAssertEqual(shows.count, 20, "shows array should contains 20 movies")
                    XCTAssertEqual(shows.first!.id, 84958, "First tv show ID should be 84958")
                    XCTAssertEqual(shows.last!.id, 95057, "Last tv show ID should be 95057")
                    expectation.fulfill()
                }
            }
        dataModel.selectedOption = TVShowDataModel.Option.popular.rawValue
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }
    
    func testCanLoadTopRatedMovies() throws {
        let expectation = expectation(description: "Loads Top Rated TV Shows")
        let cancelable = dataModel.$shows
            .sink { movies in
                XCTAssertNotNil(movies)
                if !movies.isEmpty {
                    XCTAssertEqual(movies.count, 20, "shows array should contains 20 movies")
                    XCTAssertEqual(movies.first!.id, 125910, "First tv show ID should be 125910")
                    XCTAssertEqual(movies.last!.id, 96316, "Last tv show ID should be 96316")
                    expectation.fulfill()
                }
            }
        dataModel.selectedOption = TVShowDataModel.Option.topRated.rawValue
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }

    func testCanLoadMovie() {
        let expectation = expectation(description: "Loads Show Detail")
        let cancelable = dataModel.load(tvShow: 84958)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { movie in
                XCTAssertEqual(movie.id, 84958, "Show ID should be 84958")
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }
}
