//
//  ChatViewModel.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2025/02/06.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var messages = [Message]()
    
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages() {
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)
        }
    }
    func sendMessage() {
        service.sendMessage(messageText)
    }
}
