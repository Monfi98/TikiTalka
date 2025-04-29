//
//  ChatView.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import SwiftUI

struct ChatView: View {
  
  private var currentPersona: PersonaType = .loyal
  @State private var message: String = ""
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottom) {
        
        ScrollView {
          Text("채팅이 들어갈 영역입니다.")
        }
        .frame(maxWidth: .infinity)
        
        MessageInputView(message: $message, currentPersona: currentPersona)
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
}

private struct MessageInputView: View {
  
  @Binding var message: String
  var currentPersona: PersonaType
  
  var body: some View {
    HStack(alignment: .bottom) {
      TextField("내용을 입력하세요", text: $message, axis: .vertical)
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
