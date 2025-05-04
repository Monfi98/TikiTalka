//
//  AlanAPIError.swift
//  TikiTalka
//
//  Created by 신승재 on 5/4/25.
//

import Foundation

enum AlanAPIError {
  case decodeError
  case validationError
  case unknownError(Int)
}

extension AlanAPIError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .decodeError:
      "Decode Error"
    case .validationError:
      "Validation Error"
    case .unknownError(let statusCode):
      "Unknown Error, Status Code: \(statusCode)"
    }
  }
}
