//
//  ChatUseCaseImpl.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

final class ChatUseCaseImpl: ChatUseCase {
  
  private let chatLogRepository: ChatLogRepository
  private let aiChatService: AIChatService
  
  init(chatLogRepository: ChatLogRepository, aiChatService: AIChatService) {
    self.chatLogRepository = chatLogRepository
    self.aiChatService = aiChatService
  }
  
  func startGreeting() async throws {
    <#code#>
  }
  
  func sendMessage(_ message: String) async throws {
    <#code#>
  }
  
  func reset() async throws {
    <#code#>
  }
  
  
}
