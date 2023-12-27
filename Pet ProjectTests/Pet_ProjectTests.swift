//
//  Pet_ProjectTests.swift
//  Pet ProjectTests
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import XCTest
@testable import Pet_Project

final class Pet_ProjectTests: XCTestCase {

    private var viewModel: PostViewModel!
        private let lastId: Int = 2207259
        private let lastSortingValues: Double = 9787.2163383951
        
        override func setUpWithError() throws {
            try super.setUpWithError()
            viewModel = PostViewModel()
        }
        
        override func tearDownWithError() throws {
            viewModel = nil
            try super.tearDownWithError()
        }
        
        func testFetchInitialPosts() throws {
            let expectation = XCTestExpectation(description: "Fetch initial posts")
            viewModel.fetchPosts(completion: {
                print("Fetching is completed")
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                XCTAssertFalse(self.viewModel.posts.isEmpty, "Posts should be fetched")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10)
        }
        
        func testFetchNextPage() {
            let expectation = XCTestExpectation(description: "Fetch next page posts")
            
            viewModel.fetchNextPage(lastId: lastId, lastSortingValues: lastSortingValues, completion: {
                print("Test has completed")
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                XCTAssertGreaterThan(self.viewModel.posts.count, 0, "Posts array should contain more than zero posts after fetching next page")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10)
        }

    }
