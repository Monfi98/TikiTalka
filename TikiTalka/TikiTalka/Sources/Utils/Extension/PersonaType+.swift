//
//  PersonaType+.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation
import SwiftUI

extension PersonaType {
  var name: String {
    switch self {
    case .loyal:
      "껄렁이"
    case .nerd:
      "소심이"
    case .sarcastic:
      "비꼼이"
    case .bossy:
      "고집이"
    }
  }
  
  var catchphrase: String {
    switch self {
    case .loyal:
      "헴!!!!!!!!!!!!!!\n말씀만 하십쇼!!!!!!!"
    case .nerd:
      "논문에 따르면…\n앗, 말 많았죠 죄송…"
    case .sarcastic:
      "그걸 지금 알았어요?\n천재다~"
    case .bossy:
      "내가 말이야, 니 나이 때는 말이야…"
    }
  }
  
  var summary: String {
    switch self {
    case .loyal:
      "말이 크고 세고 충성심 넘침\n분위기 띄우기와 감정 몰입 위주"
    case .nerd:
      "갑자기 TMI 폭발, 감정 공감은 서툼\n질문과 상관없는 배경지식 말함"
    case .sarcastic:
      "대놓고 비꼬지만 묘하게 팩폭 섞여 있음\n듣는 사람 빡치는데 도움이 되긴 함"
    case .bossy:
      "자꾸 옛날 이야기 꺼냄\n다 잔소리처럼 들리는데 어쩐지 틀린 말은 아님"
    }
  }
  
  var mainColor: Color {
    switch self {
    case .loyal:
        .redPrimary
    case .nerd:
        .greenPrimary
    case .sarcastic:
        .bluePrimary
    case .bossy:
        .orangePrimary
    }
  }
  
  var faceImage: Image {
    switch self {
    case .loyal:
      Image("LoyalFace")
    case .nerd:
      Image("NerdFace")
    case .sarcastic:
      Image("SarcasticFace")
    case .bossy:
      Image("BossyFace")
    }
  }
  
  var topPadding: CGFloat {
    switch self {
    case .loyal:
      70
    case .nerd:
      70
    case .sarcastic:
      30
    case .bossy:
      70
    }
  }
}
