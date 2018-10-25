//
//  NewsCell.swift
//  Hacker-news
//
//  Created by Henry Chukwu on 10/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCells(story: StoriesViewData) {
        titleLabel.text = story.title
        urlLabel.text = story.url
    }


}
