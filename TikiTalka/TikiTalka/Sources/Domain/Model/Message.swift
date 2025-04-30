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

struct GroupedMessage: Identifiable {
  let id = UUID()
  let isUser: Bool
  let timestamp: Date
  let messages: [Message]
}

extension Array where Element == Message {
  var grouped: [GroupedMessage] {
    var groups: [GroupedMessage] = []
    var currentMessages: [Message] = []
    var currentIsUser: Bool? = nil
    var currentMinute: DateComponents? = nil
    
    let calendar = Calendar.current
    
    for message in self {
      let messageMinute = calendar.dateComponents(
        [.year, .month, .day, .hour, .minute],
        from: message.timestamp
      )
      
      if currentIsUser == nil || currentMinute == nil {
        // 첫 메시지 세팅
        currentIsUser = message.isUser
        currentMinute = messageMinute
      }
      
      if message.isUser == currentIsUser, messageMinute == currentMinute {
        // 같은 사람, 같은 분이면 이어붙이기
        currentMessages.append(message)
      } else {
        // 아니면 그룹 묶고 새로운 그룹 시작
        if let currentIsUser = currentIsUser,
           let currentMinute = currentMinute,
           let date = calendar.date(from: currentMinute) {
          groups.append(
            GroupedMessage(isUser: currentIsUser, timestamp: date, messages: currentMessages)
          )
        }
        currentMessages = [message]
        currentIsUser = message.isUser
        currentMinute = messageMinute
      }
    }
    
    // 마지막 그룹 추가
    if !currentMessages.isEmpty,
       let currentIsUser = currentIsUser,
       let currentMinute = currentMinute,
       let date = calendar.date(from: currentMinute) {
      groups.append(GroupedMessage(isUser: currentIsUser, timestamp: date, messages: currentMessages))
    }
    
    return groups
  }
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
