//
//  ChatLogRepositoryImpl.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation
import SwiftData

final class ChatLogRepositoryImpl: ChatLogRepository {
  
  private let modelContext: ModelContext
  
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  
  func createChatLog(_ chatLog: ChatLog) throws {
    print("Impl:", #function)
    
    guard try fetchChatLogByDate(date: chatLog.date) == nil else {
      throw RepositoryError.dataAlreadyExist
    }

    let model = ChatLogDTO(chatLog)
    modelContext.insert(model)
  }
  
  
  func fetchChatLog(date: Date) throws -> ChatLog {
    print("Impl: ", #function)
    
    guard let data = try fetchChatLogByDate(date: date) else {
      throw RepositoryError.dataNotFound
    }
    return data.toEntity()
  }
  
  
  func updateChatLog(_ chatLog: ChatLog) throws {
    print("Impl: ", #function)
    
    guard let data = try fetchChatLogByDate(date: chatLog.date) else {
      throw RepositoryError.dataNotFound
    }
    data.messages.forEach { modelContext.delete($0) }
    data.messages = chatLog.messages.map { MessageDTO($0) }
  }
  
  
  func deleteAll() throws {
    print("Impl: ", #function)
    
    let descriptor = FetchDescriptor<ChatLogDTO>()
    let datas = try modelContext.fetch(descriptor)
    
    datas.forEach { modelContext.delete($0) }
  }
}


extension ChatLogRepositoryImpl {
  /// 지정된 날짜에 해당하는 `ChatLogDTO`를 조회합니다.
  ///
  /// 같은 날짜의 로그가 하나만 존재한다고 가정하며, 결과가 없을 경우 `nil`을 반환합니다.
  ///
  /// - Parameter date: 조회할 채팅 로그의 날짜
  /// - Returns: 조회된 `ChatLogDTO` 또는 `nil`
  /// - Throws: `RepositoryError.fetchError` - 조회 중 오류가 발생한 경우
  func fetchChatLogByDate(date: Date) throws -> ChatLogDTO? {
    let predicate = #Predicate<ChatLogDTO> { $0.date == date }
    let descriptor = FetchDescriptor(predicate: predicate)
    
    do {
      let data = try modelContext.fetch(descriptor).first
      return data
    } catch {
      throw RepositoryError.fetchError
    }
  }
}
