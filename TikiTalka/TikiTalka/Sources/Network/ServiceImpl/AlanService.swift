//
//  AlanService.swift
//  TikiTalka
//
//  Created by 신승재 on 4/27/25.
//

import Foundation

final class AlanService: AIChatService {
  // MARK: TODO 더 처리해야함,,
  func sendMessage(_ message: String) async throws -> String {
    let request = try AlanRouter(.question(message)).asURLRequest()
    let (data, response) = try await URLSession.shared.data(for: request)
    return ""
  }
  
  // MARK: TODO 더 처리해야함,,
  func reset() async throws {
    let request = try AlanRouter(.resetState).asURLRequest()
  }
}
