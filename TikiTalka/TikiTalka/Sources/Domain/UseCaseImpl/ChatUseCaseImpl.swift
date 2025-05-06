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
  
  func startGreeting(personaType: PersonaType) async throws -> Message {
    let now: Date = .now
    // 1. PersonaType에 따른 프롬프트를 넣고 AI 응답 받기
    let reply = try await aiChatService.question(
      personaType.prompt 
      +
      """
      너의 역할에 맞는 말투로 인사해줘, 너의 이름은 \(personaType.name)이야.
      너는 마크다운(Markdown) 형식 없이 평문으로만 대답해야 해.
      **굵은 글씨**, *기울임 글씨*, `코드 블록`, # 제목, - 리스트 등을 사용하지 마.  
      응답은 항상 일반 텍스트 형식이어야 하며, 시각적인 강조 없이 말투와 문장으로 표현해줘.
      """
    )
    
    // 2. Message 객체 생성
    let replyMessage = Message(isUser: false, content: reply, timestamp: now)
    
    // 3. Repository에 ChatLog 생성 후 저장
    try chatLogRepository.createChatLog(
      ChatLog(date: now.ymd, messages: [replyMessage])
    )
    return replyMessage
  }
  
  func sendMessage(_ requestMessage: Message) async throws -> Message {
    let now: Date = .now
    // 1. 사용자의 메시지를 보내고 AI 응답 받기
    let reply = try await aiChatService.question(requestMessage.content)
    
    // 2. Messag 객체 생성
    let replyMessage = Message(isUser: false, content: reply, timestamp: now)
    
    // 3. 오늘에 해당하는 Messages 가져오기
    let todayMessages = try chatLogRepository.fetchChatLog(date: now.ymd).messages
    
    // 4. 유저메시지&ai응답메시지 저장
    try chatLogRepository.updateChatLog(
      ChatLog(date: now.ymd, messages: todayMessages + [requestMessage, replyMessage])
    )
    
    // 5. AI 응답 반환
    return replyMessage
  }
  
  func reset() async throws {
    try await aiChatService.reset()
    try chatLogRepository.deleteAll()
  }
  
  func fetchChatLogs() throws -> [ChatLog] {
    return []
  }
}
