//
//  StoriesViewModel.swift
//  Hacker-news
//
//  Created by Henry Chukwu on 10/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import Foundation
import Alamofire

struct StoriesViewData {
    var title: String
    var url: String
}

protocol StoriesView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setStories(_ users: [StoriesViewData])
    func setEmptyStories()
}

class StoriesPresenter {

    weak fileprivate var storiesView : StoriesView?
    fileprivate let storyService = StoriesService()

    func attachView(_ view:StoriesView){
        storiesView = view
    }

    func detachView() {
        storiesView = nil
    }

    func getNewStories() {
        self.storiesView?.startLoading()
        storyService.execute { [weak self] stories in
            self?.storiesView?.finishLoading()
            if stories.count == 0 {
                self?.storiesView?.setEmptyStories()
            } else {
                let topStories = stories.count > 15 ? Array(stories[..<15]) : stories
                let mappedStories = topStories.map {
                    return StoriesViewData(title: $0.title, url: $0.url)
                }
                self?.storiesView?.setStories(mappedStories)
            }
        }
    }
}
