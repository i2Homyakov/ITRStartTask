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
    fileprivate var commentItems: [CommentItem]

    init(view: StoryViewProtocol, model: StoryItemProtocol, commentsDataProvider: CommentsDataProviderProtocol) {
        self.view = view
        self.storyItem = model
        self.commentItems = []
        self.commentsDataProvider = commentsDataProvider
    }

    func show() {
        view.setDate(withString: storyItem.getDateString())
        view.set(title: storyItem.title)

        self.view.showRootProgress()

        if let ids = storyItem.kids {
            weak var weakSelf = self

            commentsDataProvider.getCommentItems(ids: ids, onSuccess: { (commentItems) in

                weakSelf?.commentItems = commentItems
                weakSelf?.view.refreshComments()
                weakSelf?.view.hideRootProgress()
            }, onFailure: { (error) in

                print(error.localizedDescription)
                weakSelf?.view.hideRootProgress()
            })
        }
    }

    func getCommentItemsCount() -> Int {
        return commentItems.count
    }

    func getCommentItem(atIndex: Int) -> CommentItemProtocol? {
        if self.commentItems.indices.contains(atIndex) {
            return commentItems[atIndex]
        }

        return nil
    }

}
