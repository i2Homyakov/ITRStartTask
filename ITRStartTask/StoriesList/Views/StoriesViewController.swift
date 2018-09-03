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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: StoryCell.nibName, bundle: nil),
                                forCellReuseIdentifier: StoriesViewController.storyCellId)
        self.tableView.tableFooterView = UIView()
        self.addAnimationView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.show()
        animationView?.animate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.isNavigationBarHidden = false
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
        self.tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesViewController.storyCellId,
                                                       for: indexPath) as? StoryCell else {
            return UITableViewCell(frame: .zero)
        }

        if let storyItem = presenter?.getStoryItem(atIndex: indexPath.item) {
            cell.title = storyItem.title
            cell.dateString = storyItem.getDateString()
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
}

