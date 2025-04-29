//
//  Message.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import Foundation

struct Message: Identifiable {
  let id: UUID = UUID()
  let isUser: Bool
  let content: String
  let timestamp: Date
}

// MARK: Mock Data
extension Message {
  static let dummyMessages: [Message] = [
      Message(isUser: true, content: "안녕하세요!", timestamp: Date()),
      Message(isUser: false, content: "안녕하세요. 무엇을 도와드릴까요?", timestamp: Date()),
      Message(isUser: true, content: "오늘 날씨 알려줄 수 있어?", timestamp: Date()),
      Message(isUser: false, content: "물론이죠! 오늘은 맑고 따뜻한 날씨입니다.", timestamp: Date())
  ]
}
