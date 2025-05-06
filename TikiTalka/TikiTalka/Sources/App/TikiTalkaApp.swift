//
//  TikiTalkaApp.swift
//  TikiTalka
//
//  Created by 신승재 on 4/27/25.
//

import SwiftUI

@main
struct TikiTalkaApp: App {
  
  init() {
    DIContainer.config()
  }
  
  var body: some Scene {
    WindowGroup {
      HomeSelectView()
    }
  }
}
