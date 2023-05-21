//
//  comments.swift
//  onlineStore
//
//  Created by aaa on 3/20/23.
//

import Foundation

struct comments: Decodable {
    
    let title: [String]
    let text: [String]
    let positive: [String]
    let negative: [String]
    let like: [String]
    let dislike: [String]
    let user: [String]
    let param: [String]
    let paramRate: [[String]]
}
