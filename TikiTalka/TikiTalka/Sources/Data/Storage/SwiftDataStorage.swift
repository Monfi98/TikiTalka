//
//  SwiftDataStorage.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation
import SwiftData

final class SwiftDataStorage {
  let modelContext: ModelContext = {
    let schema = Schema([ChatLogDTO.self])
    let configuration = ModelConfiguration(
      isStoredInMemoryOnly: false
    )
    
    do {
      let container = try ModelContainer(
        for: schema,
        configurations: [configuration]
      )
      return ModelContext(container)
    } catch {
      fatalError("ModelContext Error: \(error.localizedDescription)")
    }
  }()
}

enum SwiftDataError: LocalizedError {
  case fetchError
  case deleteError
  case modelNotFound
  case modelAlreadyExist
  
  var errorDescription: String {
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
