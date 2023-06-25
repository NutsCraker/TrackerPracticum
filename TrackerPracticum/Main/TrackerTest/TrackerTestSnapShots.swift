import XCTest
import SnapshotTesting
@testable import TrackerPracticum

final class TrackerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTrackersViewControllerLight() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = TabBarViewController.configure()
        window.rootViewController = vc
        window.makeKeyAndVisible()
     
        let trackersVC = (vc.children.first as? UINavigationController)?.viewControllers.first
        print(String(describing: trackersVC))
        guard let view = trackersVC?.view else { return }
        assertSnapshot(matching: view, as: .image(traits: .init(userInterfaceStyle: .light)))
    }
    
    func testTrackersViewControllerDark() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = TabBarViewController.configure()
        window.rootViewController = vc
        window.makeKeyAndVisible()
     
        let trackersVC = (vc.children.first as? UINavigationController)?.viewControllers.first
        print(String(describing: trackersVC))
        guard let view = trackersVC?.view else { return }
        assertSnapshot(matching: view, as: .image(traits: .init(userInterfaceStyle: .dark)))
    }
}

