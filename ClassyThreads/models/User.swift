//
//  User.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation

struct User: Codable {
    var id: String
    var name:String
    var email:String
    var address:String
    var imageUrl:String
    var username: String
    var password: String
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case address
        case imageUrl
        case username
        case password
        case __v
    }
}
