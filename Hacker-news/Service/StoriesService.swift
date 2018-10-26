//
//  HackerViewModel.swift
//  Hacker-news
//
//  Created by Henry Chukwu on 10/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StoriesService {

    func execute(completion: @escaping ([Story]?) -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty"
        Alamofire.request(baseUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response) in

            var stories = [Story]()
            var requestsMade = 0


            if let data = response.data {
                do {
                    let ids = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let fetchedIds = ids as? [Int] else { return }
                    let topStories = fetchedIds.count > 10 ? Array(fetchedIds[..<10]) : fetchedIds
                    for id in topStories {
                        Alamofire.request("https://hacker-news.firebaseio.com/v0/item/\(id).json", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { response in
                            if let responseData = response.data {
                                do {
                                    let decodedId = try JSONDecoder().decode(Story.self, from: responseData)
                                    requestsMade += 1
                                    stories.append(decodedId)
                                    // call completion only when all ids have been looped through
                                    if requestsMade + 1 == topStories.count {
                                        completion(stories)
                                    }
                                } catch {
                                    print(error.localizedDescription)
                                    failure(error)
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    failure(error)
                }

            } else {
                failure(response.result.error!)
            }

        }

    }
}

