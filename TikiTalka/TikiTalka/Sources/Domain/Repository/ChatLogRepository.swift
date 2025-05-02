//
//  ChatLogRepository.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation

protocol ChatLogRepository {
  /// 새로운 채팅 로그를 생성합니다.
  ///
  /// - Parameter chatLog: 저장할 `ChatLog` 객체
  /// - Throws: 저장 중 발생할 수 있는 오류
  func createChatLog(_ chatLog: ChatLog) async throws
  
  /// 특정 날짜의 채팅 로그를 불러옵니다.
  ///
  /// - Parameter date: 조회할 날짜 (`year`, `month`, `day` 기준)
  /// - Returns: 해당 날짜의 `ChatLog` 또는 존재하지 않으면 `nil`
  /// - Throws: 불러오기 중 발생할 수 있는 오류
  func fetchChatLog(date: Date) async throws -> ChatLog?
  
  /// 기존의 채팅 로그를 업데이트합니다.
  ///
  /// - Parameter chatLog: 업데이트할 `ChatLog` 객체
  /// - Throws: 업데이트 중 발생할 수 있는 오류
  func updateChatLog(_ chatLog: ChatLog) async throws
  
  /// 저장된 모든 채팅 로그를 삭제합니다.
  ///
  /// - Throws: 삭제 중 발생할 수 있는 오류
  func deleteAll() async throws
}
