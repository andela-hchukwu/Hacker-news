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

    override func execute(completion: @escaping ([Story]) -> ()) {
        completion(story)
    }

}

class StoriesViewMock : NSObject, StoriesView {
    var setStoriesCalled = false
    var setEmptyStoriesCalled = false

    func setStories(_ users: [StoriesViewData]) {
        setStoriesCalled = true
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

    let storiesServiceMock = HackerServiceMock(story:[Story(by: "John", descendants: 2134, id: 3098, score: 21, time: Date(), title: "test hacker news", type: "sports", url: "https://www.youtube.com/watch?v=XPPMSfCdUng&index=15&list=RDM9GcyHpptMk"),
                                                     Story(by: "Henry", descendants: 32198, id: 2134, score: 32, time: Date(), title: "another test", type: "Eng", url: "https://app.farmlogs.com/#marketing/2018")])

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

    func testShouldSetUsers() {
        //given
        let storiesViewMock = StoriesViewMock()
        let storiesPresenterUnderTest = StoriesPresenter(storyService: storiesServiceMock)
        storiesPresenterUnderTest.attachView(storiesViewMock)

        //when
        storiesPresenterUnderTest.getNewStories()

        //verify
        XCTAssertTrue(storiesViewMock.setStoriesCalled)
    }

}
