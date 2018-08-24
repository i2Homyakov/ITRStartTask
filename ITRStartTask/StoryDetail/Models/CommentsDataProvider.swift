//
//  CommentsDataProvider.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 22/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class CommentsDataProvider: CommentsDataProviderProtocol {
    private var apiServiceClient: CommentsApiServiceProtocol = ApiService()

    func getCommentItems(ids: [Int],
                         onSuccess: @escaping ([CommentItem]) -> Void,
                         onFailure: @escaping (Error) -> Void) {
        self.apiServiceClient.getCommentItems(ids: ids, onSuccess: { (storyItems) in
            DispatchQueue.main.async {
                onSuccess(storyItems)
            }
        }, onFailure: { (error) in

            DispatchQueue.main.async {
                onFailure(error)
            }
        })
    }

}
