//
//  HomeSelectView.swift
//  TikiTalka
//
//  Created by 신승재 on 4/27/25.
//

import SwiftUI

struct HomeSelectView: View {
  @State private var currentPersona: PersonaType = .loyal
  
  var body: some View {
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
        
        TabView(selection: $currentPersona) {
          ForEach(PersonaType.allCases, id: \.self) {
            VStack(spacing: 0) {
              
              Spacer()
              
              Text("\"\(currentPersona.catchphrase)\"")
                .multilineTextAlignment(.center)
                .foregroundStyle(.textWhite)
                .font(.pretendard(size: 30, weight: .semiBold))
              
              Text(currentPersona.summary)
                .multilineTextAlignment(.center)
                .foregroundStyle(.textWhite)
                .font(.pretendard(size: 16, weight: .light))
                .padding(.vertical, 32)
            }.tag($0)
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(maxHeight: .infinity)
        
        SelectedIndicator(currentPersona: $currentPersona)
        
        Button {
          print("tapped")
        } label: {
          Text("시작하기")
            .padding(.horizontal, 70)
            .padding(.vertical, 15)
            .background(.buttonWhiteOpacity)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 8)
        }
      }.padding(.bottom, 70)
      
      
      
    }.background(currentPersona.mainColor)
  }
}


// MARK: - SelectedIndicator
struct SelectedIndicator: View {
  @Binding var currentPersona: PersonaType
  
  var body: some View {
    HStack {
      ForEach(PersonaType.allCases, id: \.self) {
        let size = $0 == currentPersona ? 8.0 : 6.0
        Circle()
          .fill($0 == currentPersona ? .textWhite : .buttonWhiteOpacity)
          .frame(width: size, height: size)
      }
    }.padding(.bottom, 43)
  }
}

#Preview {
  HomeSelectView()
}
