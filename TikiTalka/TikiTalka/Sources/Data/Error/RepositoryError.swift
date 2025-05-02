//
//  RepositoryError.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation

enum RepositoryError {
  case fetchError
  case deleteError
  case modelNotFound
  case modelAlreadyExist
}


extension RepositoryError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .fetchError:
      "Fetch error"
    case .deleteError:
      "Delete error"
    case .modelNotFound:
      "Model not found"
    case .modelAlreadyExist:
      "Model already exist"
    }
  }
}
