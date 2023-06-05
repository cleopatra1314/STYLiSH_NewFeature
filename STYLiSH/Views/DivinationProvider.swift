//
//  DivinationProvider.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

struct DivinationRequestBody: Codable {
    let birthday: String
    let sign: String
    let gender: String
    let color: String
}

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
        let url = URL(string: "https://hyperushle.com/api/ios/divination")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let bodyData = try! encoder.encode(STSuccessParser(data: DivinationRequestBody(birthday: "YYYY-MM-DD",
                                                                                       sign: "String",
                                                                                       gender: "men",
                                                                                       color: "#CCCCCC"), paging: nil))
        request.httpBody = bodyData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(STSuccessParser<DivinationData>.self, from: data)
                    print(response.data)
                    completion(response.data)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
