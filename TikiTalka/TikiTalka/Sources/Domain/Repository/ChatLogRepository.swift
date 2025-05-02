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
  /// 동일한 날짜의 로그가 이미 존재하는 경우, 오류를 발생시킵니다.
  ///
  /// - Parameter chatLog: 생성할 `ChatLog` 엔티티
  /// - Throws: `RepositoryError.modelAlreadyExist` 또는 저장 중 발생한 오류
  func createChatLog(_ chatLog: ChatLog) throws

  /// 지정된 날짜의 채팅 로그를 조회합니다.
  ///
  /// - Parameter date: 조회할 날짜
  /// - Returns: 조회된 `ChatLog` 엔티티
  /// - Throws: `RepositoryError.modelNotFound` 또는 조회 중 발생한 오류
  func fetchChatLog(date: Date) throws -> ChatLog

  /// 기존의 채팅 로그를 업데이트합니다.
  ///
  /// 해당 날짜에 저장된 로그가 존재하지 않으면 오류를 발생시킵니다.
  ///
  /// - Parameter chatLog: 수정할 `ChatLog` 엔티티
  /// - Throws: `RepositoryError.modelNotFound` 또는 업데이트 중 발생한 오류
  func updateChatLog(_ chatLog: ChatLog) throws

  /// 저장된 모든 채팅 로그를 삭제합니다.
  ///
  /// - Throws: 삭제 중 발생한 오류
  func deleteAll() throws
}
