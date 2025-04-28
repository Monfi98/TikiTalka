//
//  Bundle+.swift
//  TikiTalka
//
//  Created by 신승재 on 4/28/25.
//

import Foundation

extension Bundle {
  static let ALAN_API_KEY: String = {
    guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
      fatalError("Couldn't find file 'APIKey.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    
    guard let value = plist?.object(forKey: "ALAN_KEY") as? String else {
      fatalError("Couldn't find key 'ALAN_KEY' in 'APIKey.plist'.")
    }
    return value
  }()
}
