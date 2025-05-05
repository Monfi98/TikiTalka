//
//  AIChatService.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation

protocol AIChatService {
  func question(_ message: String) async throws -> String
  func reset() async throws
}
