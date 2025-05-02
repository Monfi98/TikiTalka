//
//  Date+.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import Foundation

extension Date {
  
  /// 시간 정보 없이, 년/월/일만 포함된 날짜 (00:00 고정)
  var ymd: Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: self)
    return calendar.date(from: components)!
  }
  
  /// 날짜를 지정된 형식으로 문자열로 변환합니다.
  ///
  /// - Parameter style: 변환할 날짜 형식 스타일입니다.
  /// - Returns: 지정된 형식(`DateFormatStyle`)에 맞는 문자열입니다.
  ///
  /// `style`에 따라 다음과 같은 형식이 반환됩니다:
  /// - `.ampm`: `"오후 3시 42분"`
  /// - `.full`: `"2024년 4월 28일"`
  func formattedString(style: DateFormatStyle) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    
    switch style {
    case .ampm:
      formatter.dateFormat = "a h시 m분"
    case .full:
      formatter.dateFormat = "yyyy년 M월 d일"
    }
    return formatter.string(from: self)
  }
  
  enum DateFormatStyle {
    case ampm
    case full
  }
}
