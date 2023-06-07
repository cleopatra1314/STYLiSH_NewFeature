//
//  ChatBotModel.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation


enum ChatBotSenderType: String{
    case userReplyForDress
    case userReplyForJeans
    case userReplyForHots
    case userReplyForNew
    case userReplyForDivination
    case dress
    case jeans
    case hots
    case new
    case divination
}

struct DataOfChatBotSenderType: Codable{
    let type: String
}

struct Divination: Codable{
    let image: String
}
