//
//  ChatView.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import SwiftUI

struct ChatView: View {
  
  @AppStorage("PersonaType") private var currentPersona: PersonaType = .loyal
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel = ChatViewModel()
  @State private var input: String = ""
  
  var body: some View {
    VStack(spacing: 0) {
      ChatScrollView(
        viewModel: viewModel,
        currentPersona: currentPersona
      )
      messageInput()
    }
    .background(.backgroundNormal)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          self.dismiss()
        } label: {
          Image(systemName: "chevron.left")
            .fontWeight(.semibold)
            .foregroundStyle(.textBlack)
        }
      }
      
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          viewModel.send(.initialize)
        } label: {
          Text("초기화")
            .font(.pretendard(size: 17, weight: .regular))
            .foregroundStyle(.textRed)
        }
      }
    }
    .onChange(of: viewModel.shouldDismiss) {
      if $1 { self.dismiss() }
    }
    .onAppear {
      viewModel.send(.greeting(currentPersona))
    }
  }
  
  // MARK: 채팅 메시지 입력(텍스트 필드 + 버튼)
  @ViewBuilder
  private func messageInput() -> some View {
    HStack(alignment: .bottom) {
      TextField("내용을 입력하세요", text: $input, axis: .vertical)
        .tint(currentPersona.mainColor)
        .font(.pretendard(size: 14, weight: .regular))
        .foregroundStyle(.textBlack)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background {
          RoundedRectangle(cornerRadius: 25)
            .stroke(currentPersona.mainColor, lineWidth: 1.5)
        }
      Button {
        viewModel.send(.sendMessage(input))
        self.input = ""
      } label: {
        Image(systemName: viewModel.isAIThinking ?  "square.fill" : "arrow.up")
          .foregroundStyle(.textWhite)
          .frame(width: 35, height: 35)
          .background {
            Circle()
              .fill(currentPersona.mainColor)
              .opacity(viewModel.isAIThinking ? 0.5 : 1.0)
          }
      }
      .animation(.easeInOut(duration: 0.1), value: viewModel.isAIThinking)
      .disabled(viewModel.isAIThinking)
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 16)
    .background(.backgroundNormal)
  }
}

// MARK: - ChatScrollView
private struct ChatScrollView: View {
  
  @ObservedObject var viewModel: ChatViewModel
  let currentPersona: PersonaType
  private var groupedMessages: [GroupedMessage] {
    viewModel.messages.grouped
  }
  private let bottomID = UUID()
  
  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        VStack(spacing: 16) {
          ForEach(groupedMessages) { groupedMessage in
            GroupedMessageView(
              currentPersona: currentPersona,
              groupedMessage: groupedMessage
            )
          }
          Color.clear.id(bottomID)
        }.padding(.top, 16)
      }
      .scrollIndicators(.never)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .onChange(of: groupedMessages) { _, _ in
        withAnimation {
          proxy.scrollTo(bottomID, anchor: .bottom)
        }
      }
    }
  }
}

// MARK: - GroupedMessageView
private struct GroupedMessageView: View {
  
  let currentPersona: PersonaType
  let groupedMessage: GroupedMessage
  var isUser: Bool {
    groupedMessage.isUser
  }
  
  var body: some View {
    HStack(spacing: 0) {
      
      if isUser { timestamp(date: groupedMessage.timestamp) }
      
      VStack(alignment: isUser ? .trailing : .leading, spacing: 8) {
        ForEach(groupedMessage.messages) { message in
          HStack(alignment: .top, spacing: 0) {
            if !isUser { profileImage() }
            bubble(text: message.content)
          }
        }
      }
      
      if !isUser { timestamp(date: groupedMessage.timestamp) }
    }
    .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
  }
  
  // MARK: 프로필 이미지
  @ViewBuilder
  private func profileImage() -> some View {
    ZStack {
      Circle()
        .fill(currentPersona.mainColor)
      
      currentPersona.faceImage
        .resizable()
        .scaledToFit()
        .frame(width: 30)
    }
    .frame(width: 45, height: 45)
    .padding(.trailing, 14)
  }
  
  // MARK: 채팅 옆 시간 표시
  @ViewBuilder
  private func timestamp(date: Date) -> some View {
    Text(date.formattedString(style: .ampm))
          .font(.pretendard(size: 12, weight: .regular))
          .foregroundStyle(.gray)
          .frame(maxHeight: .infinity, alignment: .bottom)
          .padding(.horizontal, 10)
          .padding(.bottom, 5)
  }
  
  // MARK: 채팅 버블
  @ViewBuilder
  private func bubble(text: String) -> some View {
    Text(text)
      .font(.pretendard(size: 14, weight: .regular))
      .foregroundStyle(isUser ? .textWhite : .textBlack)
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(isUser ? currentPersona.mainColor : .chatBubbleGray)
      .cornerRadius(
        15,
        corners: [
          isUser ? .topLeft : .topRight,
          .bottomLeft,
          .bottomRight
        ]
      )
  }
}


#Preview {
  NavigationStack {
    ChatView()
  }
}


