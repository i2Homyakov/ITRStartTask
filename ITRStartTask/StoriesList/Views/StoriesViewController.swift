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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Stories", comment: "")

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: StoryCell.nibName, bundle: nil),
                                forCellReuseIdentifier: StoriesViewController.storyCellId)
        self.tableView.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.show()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.isNavigationBarHidden = false
    }
}

extension StoriesViewController: StoriesViewProtocol {
    func refreshStories() {
        self.tableView.reloadData()
    }

    func showRootProgress() {
        rootActivityIndicatorView.startAnimating()
    }

    func hideRootProgress() {
        rootActivityIndicatorView.stopAnimating()
    }

    func setStoryImage(atIndex index: Int, image: UIImage?) {
        let indexPath = IndexPath(row: index, section: 0)

        if let cell = self.tableView.cellForRow(at: indexPath) as? StoryCell {
            if let image = image {
                cell.storyImage = image
            }

            cell.hideImageProgress()
        }
    }
}

extension StoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getStoryItemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesViewController.storyCellId,
                                                       for: indexPath) as? StoryCell else {
            return UITableViewCell(frame: .zero)
        }

        cell.reset()

        if let storyItem = presenter?.getStoryItem(atIndex: indexPath.row) {
            cell.title = storyItem.title
            cell.dateString = storyItem.getDateString()

            if storyItem.imageUrl == nil {
                cell.hideImage()
                return cell
            }

            if let image = presenter.getImage(atIndex: indexPath.row) {
                cell.storyImage = image
                return cell
            }

            cell.storyImage = UIImage(named: "EmptyStory")
            cell.showImageProgress()
        }

        return cell
    }
}

extension StoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyItem = presenter.getStoryItem(atIndex: indexPath.row) {
            let storyViewController = ViewControllersFactory.getStoryViewController(storyItem: storyItem)
            self.navigationController?.pushViewController(storyViewController, animated: true)
        }
    }

    public func tableView(_ tableView: UITableView,
                          didEndDisplaying cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
        presenter.cancelImageRequest(atIndex: indexPath.row)
    }
}
