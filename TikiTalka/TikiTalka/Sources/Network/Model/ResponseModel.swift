//
//  responseModel.swift
//  TikiTalka
//
//  Created by 신승재 on 5/5/25.
//

import Foundation

struct AlanResponse: Decodable {
    let action: Action
    let content: String

    struct Action: Decodable {
        let name: String
        let speak: String
    }
}
