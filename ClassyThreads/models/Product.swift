//
//  Product.swift
//  ClassyThreads
//
//  Created by NIBM-LAB04-PC05 on 2024-03-30.
//

import Foundation


struct ProductVM: Codable,Identifiable{
    let id: String
    let name: String
    let price:Int
    let categoryID:String
    let imageName: String
    let description:String
    let availability:Int
    let tags:[String]
    let availablesize:[String]
    let availablecolor:[String]
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageName = "imageurl"
        case price
        case categoryID
        case description
        case availability
        case tags
        case availablesize
        case availablecolor
    }
    
 
}
