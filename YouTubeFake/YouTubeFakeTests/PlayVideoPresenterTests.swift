//
//  PlayVideoPresenterTests.swift
//  YouTubeFakeTests
//
//  Created by Donovan Z. Jaimes on 02/04/24.
//

import XCTest
@testable import YouTubeFake

@MainActor class PlayVideoPresenterTests: XCTestCase {
    var sut: PlayVideoController!
    var delegate: PlayVideoViewMock!
    var providerMock : PlayVideoProviderMock!
    var videoId = "Cx2dkpBxst8"
    var timeOut : TimeInterval = 2.0
    
    @MainActor override func setUpWithError() throws {
        delegate = PlayVideoViewMock()
        providerMock = PlayVideoProviderMock()
        sut = PlayVideoController(delegate: delegate,provider: providerMock)
    }
    
    @MainActor override func tearDownWithError() throws {
        sut = nil
        delegate = nil
        providerMock = nil
    }
    
    func test_GetVideos () {
        delegate.expGetRelatedVideosFinished = expectation(description: "loading video")
        delegate.expLoading =  expectation(description: "show/hide loanding")
        delegate.expLoading?.expectedFulfillmentCount = 2
        Task{
            await sut.getVideos(videoId)
        }
        
        waitForExpectations(timeout: timeOut) //fulfill is active or ...
        guard let videos = sut.relatedVideoList.first as? [ItemVideo] else {
            XCTFail("error because the desired object does not exist in the first position")
            return
        }
        XCTAssertTrue(videos.first?.id == videoId)
        XCTAssertTrue(sut.relatedVideoList.count == 2, "Videos were not found")
        XCTAssertTrue(sut.channelModel!.id == Constants.channelIdMock, "Channel Id incorrect")
        XCTAssertTrue(delegate.loadingViewWasCalled)
        XCTAssertTrue(delegate.loandinHide)
        XCTAssertTrue(delegate.loandinShow)
    }
    
    


}
class PlayVideoViewMock: PlayVideoViewProtocol {
    var loadingViewWasCalled : Bool = false
    var showErrorWasCalled : Bool = false
    var getRelatedVideosFinishedWasCalled : Bool = false
    var expGetRelatedVideosFinished : XCTestExpectation?
    var expLoading : XCTestExpectation?
    var expShowError: XCTestExpectation?
    var loandinShow: Bool = false
    var loandinHide: Bool = false
    
    func loadingView(_ state: YouTubeFake.LoadingViewState) {
        if state == .show {
            loandinShow = true
        }else if state == .hide{
            loandinHide = true
        }
        loadingViewWasCalled = true
        expLoading?.fulfill()
        
        
    }
    
    func showError(_ error: String, callback: (() -> Void)?) {
        showErrorWasCalled = true
        expShowError?.fulfill()
    }
    
    func getRelatedVideosFinished() {
        getRelatedVideosFinishedWasCalled = true
        expGetRelatedVideosFinished?.fulfill()
    }
}
