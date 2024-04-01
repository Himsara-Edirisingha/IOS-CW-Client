//
//  CartItem.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//
import Foundation

import Foundation

struct CartItem: Codable, Identifiable {
    var id: String
    let name: String
    let price: Int
    var quantity: Int
    var colour:String
    var size:String
    let imageName: String
    var __v: Int  
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case quantity
        case colour
        case size
        case price
        case imageName
        case __v
    }
}
