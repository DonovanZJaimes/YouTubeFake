//
//  HomeViewControllerTests.swift
//  YouTubeFakeTests
//
//  Created by Donovan Z. Jaimes on 03/04/24.
//

import XCTest
@testable import YouTubeFake

final class HomeViewControllerTests: XCTestCase {
    var sut: HomeViewController!
    var provider : HomeProviderProtocol!
    var waiting : TimeInterval = 1


    @MainActor override func setUpWithError() throws {
        PresentMockManger.shared.vc = nil
        provider = HomeProviderMock()
        sut = HomeViewController()
        //sut.controller = HomeController(delegate: sut, provider: provider)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        provider = nil
        PresentMockManger.shared.vc = nil
    }

    func test_HeaderInfoTableView_ShouldContain_ChannelInfo() throws {
        let tableView = try XCTUnwrap(sut.tableView, "you should create this IBOutlet")
        
        let expLadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+waiting) {
            expLadingData.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        
        guard let header = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? ChannelTableViewCell else{
            XCTFail("The first position should be the ChannelTableViewCell")
            return
        }
        XCTAssertNotNil(header.channelTitle.text)
        XCTAssertNotNil(header.channelInfoLabel.text)
        XCTAssertNotNil(header.subscribeLabel.text)
    }

    func test_VideoSection_ValidateItsContent() throws{
        let tableView = try XCTUnwrap(sut.tableView, "you should create this IBOutlet")
        
        let expLadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            expLadingData.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        
        guard let videoCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? VideoTableViewCell else{
            XCTFail("The first position should be the VideoTableViewCell")
            return
        }
        
        let videoName = try XCTUnwrap(videoCell.videoName, "you should create this IBOutlet")
        
        XCTAssertNotNil(videoName.text)
        XCTAssertNotNil(videoCell.videoImage)
        XCTAssertNotNil(videoCell.channelName.text)
        XCTAssertNotNil(videoCell.viewsCountLabel.text)
    }
    
    func testVideoSection_ValidateIfThreeDotsButton_HasAction() throws{
        let tableView = try XCTUnwrap(sut.tableView, "you should create this IBOutlet")
        
        let expLadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+waiting) {
            expLadingData.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        
        guard let videoCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? VideoTableViewCell else{
            XCTFail("The first position should be the VideoTableViewCell")
            return
        }
        
        let dotsButton = try XCTUnwrap(videoCell.dotsButton)
        let dotsActions = try XCTUnwrap(dotsButton.actions(forTarget: videoCell, forControlEvent: .touchUpInside))
        XCTAssertEqual(dotsActions.count , 1)
        
        
        
    }
    
    
    func testVideoSection_OpenBottomSheet() throws{
        //Arrange
        let tableView = try XCTUnwrap(sut.tableView, "you should create this IBOutlet")
                
        let expLadingData = expectation(description: "loading")
                
        DispatchQueue.main.asyncAfter(deadline: .now()+waiting) {
            expLadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
                
        guard let videoCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? VideoTableViewCell else{
            XCTFail("The first position should be the VideoCell")
            return
        }
        let dotsButton = try XCTUnwrap(videoCell.dotsButton)
        dotsButton.sendActions(for: .touchUpInside)
        
        //Assert
        XCTAssertTrue(PresentMockManger.shared.vc.isKind(of: BottomSheetViewController.self))
    }

}

fileprivate class PresentMockManger{
    static var shared = PresentMockManger()
    init(){}
    var vc : UIViewController!
}

extension HomeViewController{
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        PresentMockManger.shared.vc = viewControllerToPresent
    }
}
