//
//  StoryViewController.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    var presenter: StoryPresenterProtocol!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var rootActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentsTableView.dataSource = self
        self.commentsTableView.register(UINib(nibName: "CommentCell", bundle: nil),
                                        forCellReuseIdentifier: "commentCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.show()
    }

    // otherMethods
}

extension StoryViewController: StoryViewProtocol {
    func setDate(withString: String) {
        self.dateLabel.text = withString
    }

    func set(title: String?) {
        self.titleLabel.text = title
    }

    func refreshComments() {
        self.commentsTableView.reloadData()
    }

    func showRootProgress() {
        rootActivityIndicatorView.startAnimating()
    }

    func hideRootProgress() {
        rootActivityIndicatorView.stopAnimating()
    }
}

extension StoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCommentItemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)

        guard let commentCell = cell as? CommentCell else {
            return UITableViewCell(frame: .zero)
        }

        if let commentItem = presenter?.getCommentItem(atIndex: indexPath.item) {
            commentCell.commentTextLabel.attributedText = commentItem.text?.htmlToAttributedString
            commentCell.authorLabel.text = commentItem.author
            commentCell.dateLabel.text = commentItem.getDateString()
        }

        return cell
    }

}
