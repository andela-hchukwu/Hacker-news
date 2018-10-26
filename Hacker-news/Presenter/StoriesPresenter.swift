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
    func setErrorGettingTopStories(_ error: String)
}

class StoriesPresenter {

    weak fileprivate var storiesView : StoriesView?
    fileprivate let storyService: StoriesService

    init(storyService:StoriesService){
        self.storyService = storyService
    }

    func attachView(_ view:StoriesView){
        storiesView = view
    }

    func detachView() {
        storiesView = nil
    }

    func getNewStories() {
        self.storiesView?.startLoading()
        storyService.execute(completion: { [weak self] stories in
            self?.storiesView?.finishLoading()
            if stories?.count == 0 {
                self?.storiesView?.setEmptyStories()
            } else {
                guard let story = stories else { return }
                let topStories = story.count > 15 ? Array(story[..<15]) : story
                let mappedStories = topStories.map {
                    return StoriesViewData(title: $0.title, url: $0.url)
                }
                self?.storiesView?.setStories(mappedStories)
            }
        }) { (error) in
            self.storiesView?.setErrorGettingTopStories(error.localizedDescription)
        }

    }
}
