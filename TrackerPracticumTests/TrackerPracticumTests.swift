//
//  TrackerPracticumTests.swift
//  TrackerPracticumTests
//
//  Created by Alexander Farizanov on 20.06.2023.
//
import XCTest
import SnapshotTesting
@testable import TrackerPracticum


final class TrackerPracticumTests: XCTestCase {

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        print("Test started")
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
        
    func testTrackersVC() {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let vc = TabBarViewController.configure()
            window.rootViewController = vc
            window.makeKeyAndVisible()
         
            let trackersVC = (vc.children.first as? UINavigationController)?.viewControllers.first
            print(String(describing: trackersVC))
            guard let view = trackersVC?.view else { return }
            assertSnapshot(matching: view, as: .image)
        }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
  
}
