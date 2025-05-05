//
//  ChatUseCase.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

protocol ChatUseCase {
  func startGreeting() async throws
  func sendMessage(_ message: String) async throws
  func reset() async throws
}
