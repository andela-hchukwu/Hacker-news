//
//  ViewController.swift
//  Hacker-news
//
//  Created by Henry Chukwu on 10/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var noStoryLabel: UILabel!

    fileprivate let storiesPresenter = StoriesPresenter(storyService: StoriesService())
    fileprivate var news = [StoriesViewData]()
    fileprivate var activity: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Top News"
        tableView.delegate = self
        tableView.dataSource = self
        storiesPresenter.attachView(self)
        storiesPresenter.getNewStories()
    }


}

extension StoriesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.title = "Detail Section"
            _ = vc.view
            vc.titleLabel.text = news[indexPath.row].title
            vc.detailLabel.text = news[indexPath.row].url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension StoriesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let newStories = self.news[indexPath.row]
        cell.configureCells(story: newStories)
        return cell
    }

}

extension StoriesViewController: StoriesView {

    func startLoading() {
        // Show activity indicator
        activity = UIActivityIndicatorView()
        activity!.color = UIColor.black
        activity!.center = self.view.center
        activity!.bounds = self.view.bounds
        activity!.backgroundColor = UIColor.white
        self.view.addSubview(activity!)
        activity!.startAnimating()
    }

    func finishLoading() {
        activity?.stopAnimating()
        activity?.isHidden = true
    }

    func setStories(_ stories: [StoriesViewData]) {
        news = stories
        tableView?.isHidden = false
        errorView.isHidden = true
        tableView?.reloadData()
    }

    func setEmptyStories() {
        tableView?.isHidden = true
        errorView.isHidden = false
        noStoryLabel.text = "There are no new stories to display"
    }

    func setErrorGettingTopStories(_ error: String) {
        tableView?.isHidden = true
        errorView.isHidden = false
        noStoryLabel.text = error
    }


}

