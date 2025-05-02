//
//  ChatLogDTO.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation
import SwiftData

@Model
final class ChatLogDTO {
  @Attribute(.unique) var date: Date
  @Relationship(deleteRule: .cascade)
  var messages: [MessageDTO]
  
  init(date: Date, messages: [MessageDTO]) {
    self.date = date
    self.messages = messages
  }
  
  convenience init(_ data: ChatLog) {
    self.init(
      date: data.date,
      messages: data.messages.map { MessageDTO($0) }
    )
  }
}

extension ChatLogDTO {
  func toEntity() -> ChatLog {
    return ChatLog(
      date: self.date,
      messages: self.messages.map { $0.toEntity() }
    )
  }
}
