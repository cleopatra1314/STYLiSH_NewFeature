//
//  WebSocket.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/7.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit
import SocketIO

struct Message: Codable, SocketData {
    let from: String
    let to: String
    let message: String
}

protocol WebSocketDelegate: AnyObject {
    func pass(adminMessages: [Message])
}

class WebSocket {
    static let shared = WebSocket()
    
    let manager = SocketManager(socketURL: URL(string: "https://emmalinstudio.com/")!, config: [.log(true), .compress ])
    var socket: SocketIOClient!
    weak var delegate: WebSocketDelegate?
    
    private init() {
        socket = manager.defaultSocket
        socket.connect()
        
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Connected to server")
            print("Socet sid: \(self?.socket.sid)")
        }
        
        
        socket.on("message") { [weak self] array, ack in
            guard let self = self else { return }
            let decoder = JSONDecoder()
            do {
                let data = try JSONSerialization.data(withJSONObject: array, options: [])
                let objects = try decoder.decode([STSuccessParser<Message>].self, from: data)
                let messages = objects.map { $0.data }
                let filteredMessagesFromUser = messages.filter { [weak self] in
                                                   guard let self = self else { return false }
                                                   return $0.from == self.socket.sid && $0.to == "admin"
                                               }
                let filteredMessagesFromAdmin = messages.filter { [weak self] in
                                                    guard let self = self else { return false }
                                                    return $0.from == "admin" && $0.to == self.socket.sid
                                                }
                userMessages += filteredMessagesFromUser
                adminMessages += filteredMessagesFromAdmin
                self.delegate?.pass(adminMessages: filteredMessagesFromAdmin)
            }
            catch {
                print(error)
            }
        }
    }
    
    var userMessages: [Message] = [] {
        didSet {
            print("User Messages: \(userMessages)")
        }
    }
    
    var adminMessages: [Message] = [] {
        didSet {
            print("Admin Messages: \(adminMessages)")
        }
    }
    
    lazy var getNewAdminMessage: (() -> String?) = { [weak self] in
        guard let self = self,
              let message = self.adminMessages.last?.message else { return nil }
        return message
    }
    
//    func getNewAdminMessage() -> String? {
//        guard let message = adminMessages.last?.message else { return nil }
//        return message
//    }
    
    func socketEmit(with text: String) {
        guard let sid = socket.sid else { return }
//        let message = Message(from: socket.sid!,
//                              to: "admin",
//                              message: "Test from iPhone")
        let message: [String:Any] = [
            "from": sid,
            "to": "admin",
            "message": text
        ]
//        do {
//            let encoder = JSONEncoder()
//            let message = try JSONSerialization.data(withJSONObject: <#T##Any#>)
//            let encodedMessage = try? encoder.encode(message)
//        }
        socket.emit("message", message) {
            print("Message sent from user")
        }
    }
    
    func socketEmitFromAdmin() {
        guard let sid = socket.sid else { return }
        
        let message: [String:Any] = [
            "from": "admin",
            "to": sid,
            "message": "哈囉！這裡是STYLiSH客服喔～～❤️"
        ]
        
        socket.emit("message", message) {
            print("Message sent from admin")
        }
    }
    
    
    
//    deinit {
//        socket.disconnect()
//        socket.leaveNamespace()
//    }
}
