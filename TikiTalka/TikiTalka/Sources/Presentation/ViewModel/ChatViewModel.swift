//
//  ChatViewModel.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

final class ChatViewModel: ObservableObject {
  @Published var isAIThinking: Bool = false
  @Published var messages: [Message] = []
  
  let chatUseCase: ChatUseCase
  
  init(chatUseCase: ChatUseCase) {
    self.chatUseCase = chatUseCase
  }
  
  enum Action {
    case sendMessage(String)
  }
  
  func send(_ action: Action) {
    switch action {
    case .sendMessage(let message):
      print(message)
    }
  }
}
