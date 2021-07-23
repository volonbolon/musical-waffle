//
//  MovieDataModelTests.swift
//  IMDBTests
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import XCTest
@testable import IMDB
import Combine

class MovieDataModelTests: XCTestCase {
    var dataModel: MovieDataModel!
    override func setUpWithError() throws {
        let client = MockAPIClient()
        dataModel = MovieDataModel(client: client)
    }

    func testCanLoadPopularMovies() throws {
        let expectation = expectation(description: "Loads Popular Movies")
        let cancelable = dataModel.$movies
            .sink { movies in
                XCTAssertNotNil(movies)
                if !movies.isEmpty {
                    XCTAssertEqual(movies.count, 20, "movies array should contains 20 movies")
                    XCTAssertEqual(movies.first!.id, 497698, "First movie ID should be 497698")
                    XCTAssertEqual(movies.last!.id, 503736, "Last movie ID should be 503736")
                    expectation.fulfill()
                }
            }
        dataModel.selectedOption = MovieDataModel.Option.popular.rawValue
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }
    
    func testCanLoadTopRatedMovies() throws {
        let expectation = expectation(description: "Loads Top Rated Movies")
        let cancelable = dataModel.$movies
            .sink { movies in
                XCTAssertNotNil(movies)
                if !movies.isEmpty {
                    XCTAssertEqual(movies.count, 20, "movies array should contains 20 movies")
                    XCTAssertEqual(movies.first!.id, 19404, "First movie ID should be 19404")
                    XCTAssertEqual(movies.last!.id, 122, "Last movie ID should be 122")
                    expectation.fulfill()
                }
            }
        dataModel.selectedOption = MovieDataModel.Option.topRated.rawValue
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }
    
    func testCanLoadUpcomingMovies() throws {
        let expectation = expectation(description: "Loads Upcoming Movies")
        let cancelable = dataModel.$movies
            .sink { movies in
                XCTAssertNotNil(movies)
                if !movies.isEmpty {
                    XCTAssertEqual(movies.count, 20, "movies array should contains 20 movies")
                    XCTAssertEqual(movies.first!.id, 459151, "First movie ID should be 459151")
                    XCTAssertEqual(movies.last!.id, 574060, "Last movie ID should be 574060")
                    expectation.fulfill()
                }
            }
        dataModel.selectedOption = MovieDataModel.Option.upcoming.rawValue
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }
    
    func testCanLoadMovie() {
        let expectation = expectation(description: "Loads Upcoming Movies")
        let cancelable = dataModel.load(movie: 459151)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { movie in
                XCTAssertEqual(movie.id, 459151, "Movie ID should be 459151")
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(cancelable)
    }
}
