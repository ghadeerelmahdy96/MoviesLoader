//
//  MoviesLoaderTests.swift
//  MoviesLoaderTests
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import XCTest
@testable import MoviesLoader

class MoviesLoaderTests: XCTestCase {
  var moviesHandlerWithoutError:MockMoviesHandler?
   var moviesHandlerWithError:MockMoviesHandler?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moviesHandlerWithError = MockMoviesHandler.init(shouldReturnError: true)
        moviesHandlerWithoutError = MockMoviesHandler.init(shouldReturnError: false)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testMoviesHandlerWithError()  {
        moviesHandlerWithError?.loadDataFromURL() {movies, error in
                         
                     if error != nil {
                             XCTFail()
                         }else{
                             XCTAssertEqual(movies?.count, 4, "Mocks Faild")
                         }
                     }
    }
    func testMoviesHandlerWithoutError()  {

        moviesHandlerWithoutError?.loadDataFromURL() {movies, error in
                  
              if error != nil {
                      XCTFail()
                  }else{
                      XCTAssertEqual(movies?.count, 4, "Mocks Faild")
                  }
              }
       
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

