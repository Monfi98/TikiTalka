//
//  MessageDTO.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation
import SwiftData

@Model
final class MessageDTO {
  @Attribute(.unique) var id: UUID
  var isUser: Bool
  var content: String
  var timestamp: Date
  
  init(id: UUID, isUser: Bool, content: String, timestamp: Date) {
    self.id = id
    self.isUser = isUser
    self.content = content
    self.timestamp = timestamp
  }
  
  convenience init(_ model: Message) {
    self.init(
      id: model.id,
      isUser: model.isUser,
      content: model.content,
      timestamp: model.timestamp
    )
  }
}

extension MessageDTO {
  func toEntity() -> Message {
    return Message(
      isUser: self.isUser,
      content: self.content,
      timestamp: self.timestamp
    )
  }
}
