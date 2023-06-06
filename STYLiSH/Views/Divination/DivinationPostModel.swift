//
//  DivinationPostModel.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


struct DivinationUserRequestBody: Codable{
    let birthday: String
    let sign: String
    let gender: String
    let color: String
}


struct DivinationUserPostResponse: Codable{
    let strawsStory: StrawsStory
    let couponId: Int
    let couponName: String
    let description: String
    let discount: Int
    let validDate: String
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case strawsStory = "straws_story"
        case couponId = "coupon_id"
        case couponName = "coupon_name"
        case description
        case discount
        case validDate = "valid_date"
        case products
    }
}


struct StrawsStory: Codable{
    let type: String
    let story: String
}


struct Products: Codable{
    let id: String
    let category: String
    let title: Int
    let description: String
    let price: Int
    let texture: String
    let wash: String
    let place: String
    let note: String
    let story: String
    let colors: [Colors]
    let sizes: [String]
    let variants: [Variants]
    let mainImage: String
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case category
        case title
        case description
        case price
        case texture
        case wash
        case place
        case note
        case story
        case colors
        case sizes
        case variants
        case mainImage = "main_image"
        case images
    }
}


struct Colors: Codable{
    let code: String
    let name: String
}


struct Variants: Codable{
    let colorCode: String
    let size: String
    let stock: Int
    
    enum CodingKeys: String, CodingKey {
        case colorCode = "color_code"
        case size
        case stock
    }
}

