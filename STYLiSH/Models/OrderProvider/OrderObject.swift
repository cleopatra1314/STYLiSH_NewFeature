//
//  OrderObject.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/7.
//  Copyright © 2019 AppWorks School. All rights reserved.
//

import Foundation

struct CheckoutAPIBody: Encodable {
    let order: Order
    let prime: String
}

struct Order: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case deliverTime = "shipping"
        case payment
        case productPrices = "subtotal"
        case freight
        case totalPrice = "total"
        case reciever = "recipient"
        case list
        case couponId = "coupon_id"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deliverTime, forKey: .deliverTime)
        try container.encode(payment, forKey: .payment)
        try container.encode(productPrices, forKey: .productPrices)
        try container.encode(freight, forKey: .freight)
        try container.encode(totalPrice, forKey: .totalPrice)
        try container.encode(reciever, forKey: .reciever)
        try container.encode(list, forKey: .list)
        try container.encode(couponId, forKey: .couponId)
    }
    
    var list: [OrderListObject] {
        return products.compactMap { product in
            guard
                let object = product.product,
                let name = object.title,
                let color = product.selectedColor?.toColor(),
                let size = product.seletedSize
            else {
                return nil
            }
            
            let orderObject = OrderListObject(
                id: String(object.id),
                name: name,
                price: Int(object.price),
                color: color,
                size: size,
                qty: Int(product.amount)
            )
            return orderObject
        }
    }
    
    var products: [LSOrder] = []
    var reciever: Reciever = Reciever()
    var deliverTime: String = "delivery"
    var payment: String = "cash"
    var paymentType: Payment = .cash {
        didSet {
            payment = paymentType.toString()
        }
    }
    
    var productPriceDiscount: Int?
    var freightDiscount: Int?
    var couponId: Int?
    
    var productPrices: Int {
        var price = 0
        for item in products {
            price += Int(item.product!.price) * Int(item.amount)
        }
        return price
    }

    var freight: Int {
        return products.count * 60
    }
    
    var freightToDisplay: Int {
        var price = products.count * 60
        price -= freightDiscount ?? 0
        return price
    }
    
    var productPricesToDisplay: Int {
        var price = 0
        for item in products {
            price += Int(item.product!.price) * Int(item.amount)
        }
        price -= productPriceDiscount ?? 0
        return price
    }

    var totalPrice: Int {
        return productPricesToDisplay + freightToDisplay
    }

    var amount: Int {
        var result = 0
        for item in products {
            result += Int(item.amount)
        }
        return result
    }

    func isReady() -> Bool {
        return reciever.isReady()
    }
    
    init(products: [LSOrder]) {
        self.products = products
    }
}

struct Reciever: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case phoneNumber = "phone"
        case address
        case time
        case shipTime
    }
    
    var name: String = .empty
    var email: String = .empty
    var phoneNumber: String = .empty
    var address: String = .empty
    var time: String = .empty
    var shipTime: String = .empty

    func isReady() -> Bool {
        guard
            name != .empty,
            email != .empty,
            phoneNumber != .empty,
            address != .empty
        else {
            return false
        }
        return true
    }
}

enum Payment: String, Codable {
    case cash
    case credit
    
    func title() -> String {
        switch self {
        case .cash: return NSLocalizedString("貨到付款")
        case .credit: return NSLocalizedString("信用卡付款")
        }
    }
    
    func toString() -> String {
        switch self {
        case .cash: return "cash"
        case .credit: return "credit_card"
        }
    }
}

struct OrderListObject: Codable {
    let id: String
    let name: String
    let price: Int
    let color: Color
    let size: String
    let qty: Int
}
