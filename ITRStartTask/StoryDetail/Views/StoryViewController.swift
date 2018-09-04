//
//  StoryViewController.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, XibInitializable {
    fileprivate static let commentCellId = "commentCell"
    fileprivate static let headerCellId = "headerCell"

    var presenter: StoryPresenterProtocol!

    @IBOutlet weak var rootTableView: UITableView!
    @IBOutlet weak var rootActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootTableView.dataSource = self
        self.rootTableView.register(UINib(nibName: CommentCell.nibName, bundle: nil),
                                        forCellReuseIdentifier: StoryViewController.commentCellId)
        self.rootTableView.register(UINib(nibName: StoryHeaderCell.nibName, bundle: nil),
                                        forCellReuseIdentifier: StoryViewController.headerCellId)

        self.title = NSLocalizedString("Story", comment: "")

        replaceBackButton()
    }

    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        presenter.show()
    }

    private func replaceBackButton() {
        let button = UIBarButtonItem(image: UIImage(named: "BackButton"),
                                     style: UIBarButtonItemStyle.plain,
                                     target: self,
                                     action: #selector(backPressed))
        button.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = button
    }
}

extension StoryViewController: StoryViewProtocol {
    func refreshComments() {
        self.rootTableView.reloadData()
    }

    func showRootProgress() {
        rootActivityIndicatorView.startAnimating()
    }

    func hideRootProgress() {
        rootActivityIndicatorView.stopAnimating()
    }
}

extension StoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? presenter.getCommentItemsCount() : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryViewController.commentCellId, for: indexPath)

            guard let commentCell = cell as? CommentCell else {
                return UITableViewCell(frame: .zero)
            }

        guard let commentItem = presenter?.getCommentItem(atIndex: indexPath.item) else {
            return UITableViewCell(frame: .zero)
            }

        commentCell.commentText = commentItem.textAttributedString
        commentCell.author = commentItem.author
        commentCell.dateString = commentItem.getFormattedDateString()

            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: StoryViewController.headerCellId, for: indexPath)

        guard let headerCell = cell as? StoryHeaderCell else {
            return UITableViewCell(frame: .zero)
        }

        if let storyItem = presenter?.getStoryItem() {
            headerCell.title = storyItem.title
        }

        return cell
    }
}
