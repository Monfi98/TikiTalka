//
//  Message.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import Foundation

struct Message: Identifiable, Equatable {
  let id: UUID = UUID()
  let isUser: Bool
  let content: String
  let timestamp: Date
}


// MARK: Mock Data
extension Message {
  static let dummyMessages: [Message] = [
    Message(
      isUser: false,
      content: "무엇이든지 물어보세요!",
      timestamp: Calendar.current.date(byAdding: .minute, value: 0, to: Date())!),
    Message(
      isUser: true,
      content: "오늘 날씨 알려줄수 있어?",
      timestamp: Calendar.current.date(byAdding: .minute, value: 2, to: Date())!),
    Message(
      isUser: true,
      content: "최대한 간략하게 알려주라 굿데이굿데이 굿데이굿데이 굿데이굿데이 굿데이굿데이 굿데이굿데이 굿데이굿데이",
      timestamp: Calendar.current.date(byAdding: .minute, value: 2, to: Date())!),
    Message(
      isUser: false,
      content: "물론이죠! 오늘은 맑고 따뜻한 날씨입니다. 물론이죠! 오늘은 맑고 따뜻한 날씨입니다. 물론이죠! 오늘은 맑고 따뜻한 날씨입니다.",
      timestamp: Calendar.current.date(byAdding: .minute, value: 4, to: Date())!),
  ]
}
