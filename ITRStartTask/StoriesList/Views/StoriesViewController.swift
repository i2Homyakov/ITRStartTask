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
    private weak var animationView: AnimationLaunchScreenView?

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
        self.addAnimationView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.show()
        animationView?.startAnimation()
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

    private func addAnimationView() {
        let animationView = AnimationLaunchScreenView(frame: UIScreen.main.bounds)

        if let window = UIApplication.shared.keyWindow {
            window.addSubview(animationView)
            animationView.translatesAutoresizingMaskIntoConstraints = false
            self.animationView = animationView
            let views = ["animationView": animationView]

            var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[animationView]|",
                                                             options: [],
                                                             metrics: nil,
                                                             views: views)

            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[animationView]|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: views)

            window.addConstraints(constraints)
        }
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

        if let storyItem = presenter?.getStoryItem(atIndex: indexPath.item) {
            storyCell.title = storyItem.title
            storyCell.dateString = storyItem.getDateString()
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
