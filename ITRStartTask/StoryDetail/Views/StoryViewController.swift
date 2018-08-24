//
//  StoryViewController.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    fileprivate static let commentCellId = "commentCell"
    fileprivate static let headerCellId = "headerCell"

    var presenter: StoryPresenterProtocol!

    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var rootActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentsTableView.dataSource = self
        self.commentsTableView.register(UINib(nibName: CommentCell.nibName, bundle: nil),
                                        forCellReuseIdentifier: StoryViewController.commentCellId)
        self.commentsTableView.register(UINib(nibName: StoryHeaderCell.nibName, bundle: nil),
                                        forCellReuseIdentifier: StoryViewController.headerCellId)

        self.title = NSLocalizedString("Story", comment: "")

        replaceBackButton()
    }

    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        self.commentsTableView.reloadData()
    }

    func showRootProgress() {
        rootActivityIndicatorView.startAnimating()
    }

    func hideRootProgress() {
        rootActivityIndicatorView.stopAnimating()
    }

    static func xibInstance () -> StoryViewController {
        return StoryViewController(nibName: "StoryViewController", bundle: nil)
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

            if let commentItem = presenter?.getCommentItem(atIndex: indexPath.item) {
                commentCell.commentText = commentItem.text
                commentCell.author = commentItem.author
                commentCell.dateString = commentItem.getDateString()
            }

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
