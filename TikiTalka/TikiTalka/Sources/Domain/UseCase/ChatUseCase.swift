//
//  ChatUseCase.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

protocol ChatUseCase {
  
  /// 선택한 페르소나 타입에 맞는 초기 인사 메시지를 받아옵니다.
  ///
  /// - Parameter personaType: 현재 선택된 페르소나 (`PersonaType`)
  /// - Returns: AI가 응답한 초기 인사 메시지 (`Message`)
  /// - Throws: Alan API 오류 또는 Repository 오류 등
  func startGreeting(personaType: PersonaType) async throws -> Message
  
  /// 사용자의 메시지를 전송하고 AI의 응답 메시지를 받아옵니다.
  ///
  /// - Parameter requestMessage: 사용자가 입력한 메시지 (`Message`)
  /// - Returns: AI가 응답한 메시지 (`Message`)
  /// - Throws: Alan API 오류 또는 Repository 오류 등
  func sendMessage(_ requestMessage: Message) async throws -> Message
  
  /// 현재 AI 세션(대화 상태)을 초기화합니다.
   ///
   /// - Throws: Alan API 오류 또는 Repository 오류 등
  func reset() async throws
}
