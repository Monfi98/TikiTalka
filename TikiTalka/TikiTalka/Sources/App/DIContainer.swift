//
//  DIContainer.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

class DIContainer {
  
  static let shared = DIContainer()
  
  private var dependencies = [String: Any]()
  
  private init() {}
  
  func register<T>(_ dependency: T, for type: T.Type) {
    let key = String(describing: type)
    dependencies[key] = dependency
  }
  
  func resolve<T>(_ type: T.Type) -> T {
    let key = String(describing: type)
    guard let dependency = dependencies[key] else {
      preconditionFailure("\(key)는 register되지 않았어요. resolve 부르기 전에 register 해주세요")
    }
    return dependency as! T
  }
}


@propertyWrapper
class Dependency<T> {
  let wrappedValue: T
  
  init() {
    self.wrappedValue = DIContainer.shared.resolve(T.self)
  }
}

extension DIContainer {
  static func config() {
    let storage = SwiftDataStorage()
    let chatLogRepository = ChatLogRepositoryImpl(modelContext: storage.modelContext)
    let aiChatService = AlanService()
    self.shared.register(
      ChatUseCaseImpl(
        chatLogRepository: chatLogRepository,
        aiChatService: aiChatService
      ),
      for: ChatUseCase.self
    )
  }
}
