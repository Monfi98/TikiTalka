//
//  Date+.swift
//  TikiTalka
//
//  Created by 신승재 on 4/29/25.
//

import Foundation

import Foundation

extension Date {
    enum DateFormatStyle {
        case ampm       // "오후 3시 42분"
        case full        // "2024년 4월 28일"
    }
    
    func formatted(style: DateFormatStyle) -> String {
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
}
