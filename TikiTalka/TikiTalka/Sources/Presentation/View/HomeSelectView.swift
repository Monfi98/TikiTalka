//
//  HomeSelectView.swift
//  TikiTalka
//
//  Created by 신승재 on 4/27/25.
//

import SwiftUI

struct HomeSelectView: View {
  @AppStorage("PersonaType") private var currentPersona: PersonaType = .loyal
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        
        currentPersona.faceImage
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 390)
          .rotationEffect(.degrees(-20.2))
          .padding(.top, currentPersona.topPadding)
          .offset(x: 21)
        
        VStack {
          Text(currentPersona.name)
            .foregroundStyle(.textWhite)
            .font(.pretendard(size: 40, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 24)
          
          SlideContentView(currentPersona: $currentPersona)
          
          pageIndicator()
            .padding(.bottom, 43)
          
          NavigationLink(destination: ChatView()) {
            Text("시작하기")
              .foregroundStyle(.textWhite)
              .padding(.horizontal, 70)
              .padding(.vertical, 15)
              .background(.buttonWhiteOpacity)
              .clipShape(Capsule())
              .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 8)
          }
        }.padding(.bottom, 70)
      }
      .background(currentPersona.mainColor)
      .animation(.easeInOut(duration: 0.25), value: currentPersona)
    }
  }
  
  @ViewBuilder
  private func pageIndicator() -> some View {
    HStack {
      ForEach(PersonaType.allCases, id: \.self) {
        let size = $0 == currentPersona ? 8.0 : 6.0
        Circle()
          .fill($0 == currentPersona ? .textWhite : .buttonWhiteOpacity)
          .frame(width: size, height: size)
      }
    }
  }
}

struct SlideContentView: View {
  
  @Binding var currentPersona: PersonaType
  
  var body: some View {
    TabView(selection: $currentPersona) {
      ForEach(PersonaType.allCases, id: \.self) {
        VStack(spacing: 0) {
          
          Text("\"\(currentPersona.catchphrase)\"")
            .multilineTextAlignment(.center)
            .foregroundStyle(.textWhite)
            .font(.pretendard(size: 30, weight: .semiBold))
          
          Text(currentPersona.summary)
            .multilineTextAlignment(.center)
            .foregroundStyle(.textWhite)
            .font(.pretendard(size: 16, weight: .light))
            .padding(.vertical, 32)
          
        }
        .tag($0)
        .frame(maxHeight: .infinity, alignment: .bottom)
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
  }
}

#Preview {
  HomeSelectView()
}
