//
//  ChatViewModel.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

final class ChatViewModel: ObservableObject {
  
  @Published var isAIThinking: Bool = false
  @Published var shouldDismiss: Bool = false
  @Published var messages: [Message] = []
  
  @Dependency private var chatUseCase: ChatUseCase
  
  enum Action {
    case greeting(PersonaType)
    case sendMessage(String)
    case initialize
  }
  
  func send(_ action: Action) {
    switch action {
    case .greeting(let personaType):
      greeting(type: personaType)
    case .sendMessage(let message):
      sendMessage(message: message)
    case .initialize:
      reset()
    }
  }
}

extension ChatViewModel {
  private func greeting(type: PersonaType) {
    Task { @MainActor in
      isAIThinking = true
      messages.append(Constants.loadingMessage)
      do {
        let replyMessage = try await chatUseCase.startGreeting(personaType: type)
        messages.removeLast()
        messages.append(replyMessage)
      } catch {
        print(error.localizedDescription)
      }
      isAIThinking = false
    }
  }
  
  private func sendMessage(message: String) {
    let requestMessage = Message(isUser: true, content: message, timestamp: .now)
    messages.append(requestMessage)
    Task { @MainActor in
      isAIThinking = true
      messages.append(Constants.loadingMessage)
      do {
        let replyMessage = try await chatUseCase.sendMessage(requestMessage)
        messages.removeLast()
        messages.append(replyMessage)
      } catch {
        print(error.localizedDescription)
      }
      isAIThinking = false
    }
  }
  
  private func reset() {
    Task { @MainActor in
      try await chatUseCase.reset()
      self.shouldDismiss = true
    }
  }
}
