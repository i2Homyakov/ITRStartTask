//
//  CommentItemProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 22/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

protocol CommentItemProtocol: TimeProtocol {
    var author: String? { get }
    var text: String? { get }
}
