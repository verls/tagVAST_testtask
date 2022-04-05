//
//  tagVAST_testtaskTests.swift
//  tagVAST_testtaskTests
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import XCTest
@testable import tagVAST_testtask

class tagVAST_testtaskTests: XCTestCase {
    
    private var services: Services!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        services = Services()
        services.append(ConfigService.self,implementation: ConfigImpl(services: services))
        services.append(DownloaderService.self, implementation: DownloaderImpl(services: services))
        services.append(ProviderService.self, implementation: PixabayProvider(services: services))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConfig() throws {
        if let config = services.resolve(ConfigService.self) as? ConfigService {
            XCTAssert(!config.pixabayKey.isEmpty, "pixabay config key is empty")
            print(config.pixabayKey)
        } else {
            XCTFail("Can't resolve Config dependancy")
        }
    }

    func testDownloader() throws {
        if let loader = services.resolve(DownloaderService.self) as? DownloaderService {
            let expectation = XCTestExpectation(description: "Loading a file asynchronously.")
            let url = URL(string: "https://player.vimeo.com/external/328940142.hd.mp4?s=1ea57040d1487a6c9d9ca9ca65763c8972e66bd4&profile_id=175")!
            loader.loadData(with: url) { res in
                switch res {
                case .success(let data):
                    XCTAssertNotNil(data)
                    XCTAssert(data!.count > 0, "data should have bytes")
                    print("bytes: \(data!.count)")
                case .failure(let err):
                    XCTFail("Failed loading: \(err.localizedDescription)")
                }
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 10.0)
        } else {
            XCTFail("Can't resolve downloader dependancy")
        }
    }
    
    func testProvider() throws {
        if let provider = services.resolve(ProviderService.self) as? ProviderService {
            let expectation = XCTestExpectation(description: "Making searh a file asynchronously.")
            
            provider.search(term: "yellow flowers") { res in
                switch res {
                case .failure(let err): XCTFail("Search failed: \(err.localizedDescription)")
                case .success(let results):
                    XCTAssertFalse(results.isEmpty, "empty results")
                    expectation.fulfill()
                }
            }
            
            
        
            wait(for: [expectation], timeout: 10.0)
        } else {
            XCTFail("Can't resolve downloader dependancy")
        }
    }
}
