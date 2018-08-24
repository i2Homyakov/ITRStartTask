//
//  StoryPresenterImplementation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryPresenter: StoryPresenterProtocol {
    var view: StoryViewProtocol
    var storyItem: StoryItemProtocol
    private var commentsDataProvider: CommentsDataProviderProtocol
    fileprivate var commentItemModels: [CommentItemModel]

    init(view: StoryViewProtocol, model: StoryItemProtocol, commentsDataProvider: CommentsDataProviderProtocol) {
        self.view = view
        self.storyItem = model
        self.commentItemModels = []
        self.commentsDataProvider = commentsDataProvider
    }

    func show() {
        view.setDate(withString: storyItem.getDateString())
        view.set(title: storyItem.title)

        self.view.showRootProgress()

        if let ids = storyItem.kids {
            let ids = ids.count > 5 ? Array(ids[0..<5]) : ids

            commentsDataProvider.getCommentItems(ids: ids, onSuccess: { [weak self] (commentItems) in
                self?.commentItemModels = commentItems.map {CommentItemModel(commentItem: $0)}
                self?.view.refreshComments()
                self?.view.hideRootProgress()
            }, onFailure: { [weak self] (error) in
                print(error.localizedDescription)
                self?.view.hideRootProgress()
            })
        }
    }

    func getCommentItemsCount() -> Int {
        return commentItemModels.count
    }

    func getCommentItem(atIndex: Int) -> CommentItemModelProtocol? {
        return 0 <= atIndex && atIndex < self.commentItemModels.count
            ? commentItemModels[atIndex]
            : nil
    }

}
