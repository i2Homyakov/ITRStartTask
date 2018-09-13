//
//  StoriesViewController.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController, XibInitializable {
    fileprivate static let storyCellId = "storyCell"

    var presenter: StoriesPresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rootActivityIndicatorView: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: StoryCell.nibName, bundle: nil),
                           forCellReuseIdentifier: StoriesViewController.storyCellId)
        tableView.tableFooterView = UIView()
        addRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.show()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @objc func refresh() {
        presenter.refresh()
    }

    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Updating", comment: "")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
}

extension StoriesViewController: StoriesViewProtocol {
    func refreshStories() {
        tableView.reloadData()
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    func showRootProgress() {
        rootActivityIndicatorView.startAnimating()
    }

    func hideRootProgress() {
        rootActivityIndicatorView.stopAnimating()
    }
}

extension StoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getStoryItemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoriesViewController.storyCellId, for: indexPath)

        guard let storyCell = cell as? StoryCell else {
            return UITableViewCell()
        }

        storyCell.reset()

        if let storyItem = presenter?.getStoryItem(atIndex: indexPath.row) {
            storyCell.title = storyItem.title
            storyCell.dateString = storyItem.getDateString()

            if storyItem.imageUrl == nil {
                storyCell.hideImage()
                return cell
            }

            if let image = presenter.getImage(forStoryItem: storyItem) {
                storyCell.storyImage = image
            } else {
                storyCell.cancelImageDownload = { [weak self] in
                    self?.presenter.cancelImageDownload(forStoryItem: storyItem)
                }

                presenter.downloadImage(forStoryItem: storyItem, onSuccess: { image in
                    storyCell.storyImage = image
                    storyCell.hideImageProgress()
                }, onFailure: { _ in
                    storyCell.hideImageProgress()
                })

                storyCell.storyImage = UIImage(named: "EmptyStory")
                storyCell.showImageProgress()
            }
        }

        return storyCell
    }
}

extension StoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyItem = presenter.getStoryItem(atIndex: indexPath.row) {
            let storyViewController = ViewControllersFactory.getStoryViewController(storyItem: storyItem)
            navigationController?.pushViewController(storyViewController, animated: true)
        }
    }
}
