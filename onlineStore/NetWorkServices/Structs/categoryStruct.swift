//
//  categoryStruct.swift
//  onlineStore
//
//  Created by aaa on 2/28/23.
//

import Foundation


struct categoryStruct {
    var sectionName: String
    var cellObjects: [String]
    var images: [String]
}

struct Category: Decodable {
    let title: String
    let img_name: String
    let cat: String
    let detail: String
}
