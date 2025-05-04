//
//  AlanService.swift
//  TikiTalka
//
//  Created by 신승재 on 4/27/25.
//

import Foundation

final class AlanService: AIChatService {
  func sendMessage(_ message: String) async throws -> String {
    let request = try AlanRouter(.question(message)).asURLRequest()
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
       throw URLError(.badServerResponse)
     }
    
    switch httpResponse.statusCode {
    case 200:
      return try JSONDecoder().decode(String.self, from: data)
    case 422:
      throw AlanAPIError.validationError
    default:
      throw AlanAPIError.unknownError(httpResponse.statusCode)
    }
  }
  
  // MARK: TODO 더 처리해야함,,
  func reset() async throws {
    let request = try AlanRouter(.resetState).asURLRequest()
  }
}
