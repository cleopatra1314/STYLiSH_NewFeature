//
//  WebSocket.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/7.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit
import SocketIO

class WebSokcet {
    static let shared = WebSokcet()
    
    struct Message: Codable, SocketData {
        let from: String
        let to: String
        let message: String
    }
    
    let manager = SocketManager(socketURL: URL(string: "https://emmalinstudio.com/")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
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
                let filteredMessages = objects.map { $0.data }
                                              .filter { [weak self] in
                                                  guard let self = self else { return false }
                                                  if $0.from == self.socket.sid && $0.to == "admin" {
                                                        return true
                                                  } else if $0.from == "admin" && $0.to == self.socket.sid {
                                                        return true
                                                  } else {
                                                        return false
                                                  }
                                              }
                messages += filteredMessages
                print(objects)
            }
            catch {
                print(error)
            }
        }
    }
    
    var messages: [Message] = [] {
        didSet {
            print(messages)
        }
    }
    
    func socketEmit() {
        guard let sid = socket.sid else { return }
//        let message = Message(from: socket.sid!,
//                              to: "admin",
//                              message: "Test from iPhone")
        let message: [String:Any] = [
            "from": sid,
            "to": "admin",
            "message": "Test from iPhone"
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
