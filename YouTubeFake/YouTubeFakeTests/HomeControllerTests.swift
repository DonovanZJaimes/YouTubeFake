//
//  HomeControllerTests.swift
//  YouTubeFakeTests
//
//  Created by Donovan Z. Jaimes on 02/04/24.
//

import XCTest
@testable import YouTubeFake

class HomeControllerTests: XCTestCase {
    var sut: HomeController!
    var sutDelegate : HomeViewMock!
    //var provider : HomeProviderMock!
    var provider : HomeProvider!
    @MainActor override func setUpWithError() throws {
        sutDelegate = HomeViewMock()
        //provider = HomeProviderMock()
        provider = HomeProvider()
        sut = HomeController(delegate: sutDelegate, provider: provider)
    }

    @MainActor override func tearDownWithError() throws {
        sut = nil
        sutDelegate = nil
        provider = nil
    }
    
    func test_GetHomeObjects_WhenLoad_ObjectsShoutBeInCorrectPosition() async {
        await sut.getHomeObjects()
        
        XCTAssertTrue(sutDelegate.objectList![0] is [ItemsChannel], "this first position should be of type ItemsChannel")
        XCTAssertTrue(sutDelegate.objectList![1] is [ItemPlaylistItems], "this second position should be of type ItemPlaylistItems ")
        XCTAssertTrue(sutDelegate.objectList![2] is [ItemVideo], "this third position should be of type ItemVideo")
        XCTAssertTrue(sutDelegate.objectList![3] is [ItemsPlaylist],  "this fourth position should be of type ItemsPlaylist")
    }
    
    func test_GetHomeObjects_WhenLoad_SectionTitlesShouldBeCorrect() async {
           //Arrange
           let expectSectionTitle0 = ""
           let expectSectionTitle2 = "Uploads"
           let expectSectionTitle3 = "Created playlist"
           
           //Act
           await sut.getHomeObjects()
           
           //Assert
           XCTAssertEqual(sutDelegate.sectionTitleList![0], expectSectionTitle0)
           XCTAssertEqual(sutDelegate.sectionTitleList![2], expectSectionTitle2)
           XCTAssertEqual(sutDelegate.sectionTitleList![3], expectSectionTitle3)
           
       }

   
}
class HomeViewMock : HomeControllerDelegate{
    var objectList : [[Any]]?
    var sectionTitleList : [String]?
    var throwError : Bool = false
    
    func homeController(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
    }
    
    
    func loadingView(_ state: LoadingViewState) {
        
    }
    
    func showError(_ error: String, callback: (() -> Void)?) {
        throwError = true
    }
}
