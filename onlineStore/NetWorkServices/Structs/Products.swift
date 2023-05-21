//
//  amazingsStruct.swift
//  onlineStore
//
//  Created by aaa on 2/8/23.
//

import Foundation

struct Products: Decodable {
    let img_name: String
    let name: String
    let price: String
    let prevPrice: String
    let detail: String
}
