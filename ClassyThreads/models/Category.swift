//
//  Category.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation


struct Category: Codable {
    let id: String
    let name: String
    let imageName: String
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageName
        case __v
    }
}
