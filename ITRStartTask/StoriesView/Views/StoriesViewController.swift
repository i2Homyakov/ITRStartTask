//
//  StoriesViewController.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    var presenter: StoriesPresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rootActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "StoryCell", bundle: nil), forCellReuseIdentifier: "storyCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.show()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.isNavigationBarHidden = false
    }

    // otherMethods
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as? StoryCell else {
            return UITableViewCell(frame: .zero)
        }

        if let storyItem = presenter?.getStoryItem(atIndex: indexPath.item) {
            cell.titleUILabel.text = storyItem.title
        }

        return cell
    }

}

extension StoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyItem = presenter.getStoryItem(atIndex: indexPath.row) {
            let destination = ViewControllersFactory.getStoryViewController(storyItem: storyItem)
//            self.navigationController?.show(destination, sender: self)
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }

}
