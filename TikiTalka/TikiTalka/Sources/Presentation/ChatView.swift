//
//  ChatView.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import SwiftUI

struct ChatView: View {
  
  private var currentPersona: PersonaType = .loyal
  @State private var input: String = ""
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ChatScrollView(currentPersona: currentPersona)
      MessageInputView(input: $input, currentPersona: currentPersona)
    }
    .background(.backgroundNormal)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          print("tapped")
        } label: {
          Image(systemName: "chevron.left")
            .fontWeight(.semibold)
            .foregroundStyle(.textBlack)
        }
      }
      
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          print("tapped")
        } label: {
          Text("초기화")
            .font(.pretendard(size: 17, weight: .regular))
            .foregroundStyle(.textRed)
        }
      }
    }
  }
}

// MARK: - ChatScrollView
private struct ChatScrollView: View {
  
  @State private var messages = Message.dummyMessages.grouped
  let currentPersona: PersonaType
  
  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        ForEach(messages) { groupedMessage in
          GroupedMessageView(
            currentPersona: currentPersona,
            groupedMessage: groupedMessage
          )
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
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
      
      if isUser {
        timestamp(date: groupedMessage.timestamp)
      }
      
      VStack(alignment: isUser ? .trailing : .leading) {
        ForEach(groupedMessage.messages) { message in
          HStack(spacing: 0) {
            if !isUser { profileImage() }
            
            bubble(text: message.content)
          }
        }
      }
      
      if !isUser { timestamp(date: groupedMessage.timestamp) }
    }
    .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
  }
  
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
  
  @ViewBuilder
  private func timestamp(date: Date) -> some View {
    Text(date.formatted(style: .ampm))
          .font(.pretendard(size: 12, weight: .regular))
          .foregroundStyle(.gray)
          .frame(maxHeight: .infinity, alignment: .bottom)
          .padding(.horizontal, 10)
          .padding(.bottom, 5)
  }
  
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


// MARK: - MessageInputView
private struct MessageInputView: View {
  
  @Binding var input: String
  var currentPersona: PersonaType
  
  var body: some View {
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
        print("tapped")
      } label: {
        Image(systemName: "arrow.up")
          .foregroundStyle(.textWhite)
          .frame(width: 35, height: 35)
          .background {
            Circle()
              .fill(currentPersona.mainColor)
          }
      }
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 16)
    .background(.backgroundNormal)
  }
}

#Preview {
  NavigationStack {
    ChatView()
  }
}


