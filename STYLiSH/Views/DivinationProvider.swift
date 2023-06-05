//
//  DivinationProvider.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

struct DivinationData: Codable {
    struct StrawsStory: Codable {
        let type: String
        let story: String
    }
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

struct StrawStory: Codable {
    let type: String
    let story: String
}

class DivinationProvider {
    static let shared = DivinationProvider()
    
    private init() {}
    
    func fetchDivinationResult(completion: @escaping ((DivinationData) -> Void) ) {
        let url = URL(string: "http://54.153.203.119//api/1.0/ios/divination")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(STSuccessParser<DivinationData>.self, from: data)
                    completion(response.data)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
