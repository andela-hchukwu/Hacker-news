//
//  StoriesPresenter.swift
//  Hacker-news
//
//  Created by Henry Chukwu on 10/24/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import XCTest
@testable import Hacker_news

class HackerServiceMock: StoriesService {
    fileprivate let story: [Story]
    init(story: [Story]) {
        self.story = story
    }

    override func getUsers(_ callBack: @escaping ([Story]) -> Void) {
        callBack(story)
    }

}

class StoriesViewMock : NSObject, StoriesView {
    var setStoriesCalled = false
    var setEmptyStoriesCalled = false

    func setStories(_ users: [StoriesViewData]) {
        setUsersCalled = true
    }

    func setEmptyStories() {
        setEmptyStoriesCalled = true
    }

    func startLoading() {
    }

    func finishLoading() {
    }

}

class StoriesPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testShouldSetEmptyIfNoUserAvailable() {
        //given
        let userViewMock = UserViewMock()
        let userPresenterUnderTest = UserPresenter(userService: emptyUsersServiceMock)
        userPresenterUnderTest.attachView(userViewMock)

        //when
        userPresenterUnderTest.getUsers()

        //verify
        XCTAssertTrue(userViewMock.setEmptyUsersCalled)
    }

}
