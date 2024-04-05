//
//  MainViewControllerTests.swift
//  YouTubeFakeTests
//
//  Created by Donovan Z. Jaimes on 03/04/24.
//

import XCTest
@testable import YouTubeFake

final class MainViewControllerTests: XCTestCase {
    var sut: YouTubeMainViewController!
    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "YouTubeMain", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "YouTubeMainVC") as! YouTubeMainViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        let tabs = try XCTUnwrap(sut.tabsView)
    }

    

}
