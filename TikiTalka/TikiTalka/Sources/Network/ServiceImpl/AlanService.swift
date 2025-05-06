//
//  AlanService.swift
//  TikiTalka
//
//  Created by 신승재 on 4/27/25.
//

import Foundation

final class AlanService: AIChatService {
  
  func question(_ message: String) async throws -> String {
    let request = AlanRouter(.question(message)).asURLRequest()
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
       throw URLError(.badServerResponse)
     }
    
    switch httpResponse.statusCode {
    case 200:
      let response = try JSONDecoder().decode(AlanResponse.self, from: data)
      return response.content
    case 422:
      throw AlanAPIError.validationError
    default:
      throw AlanAPIError.unknownError(httpResponse.statusCode)
    }
  }
  
  func reset() async throws {
    let request = AlanRouter(.resetState).asURLRequest()
    let (_, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    
    switch httpResponse.statusCode {
    case 200:
      break
    case 422:
      throw AlanAPIError.validationError
    default:
      throw AlanAPIError.unknownError(httpResponse.statusCode)
    }
  }
}
