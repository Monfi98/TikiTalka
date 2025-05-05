//
//  AlanRouter.swift
//  TikiTalka
//
//  Created by 신승재 on 5/2/25.
//

import Foundation

struct AlanRouter {

  private let api: API
  
  init(_ api: API) {
    self.api = api
  }
  
  enum API {
    case question(String)
    case plainStreamingQuestion(String)
    case sseStreamingQuestion(String)
    case resetState
    case summaryYoutube
  }
  
  private var baseURL: URL {
    URL(string: "https://kdt-api-function.azurewebsites.net")!
  }
  
  private var path: String {
    switch api {
    case .question:
      "/api/v1/question"
    case .plainStreamingQuestion:
      "/api/v1/question/plain-streaming"
    case .sseStreamingQuestion:
      "/api/v1/question/sse-streaming"
    case .resetState:
      "/api/v1/reset-state"
    case .summaryYoutube:
      "/api/v1/summary-youtube"
    }
  }
  
  private var method: String {
    switch api {
    case .question:
      "GET"
    case .plainStreamingQuestion:
      "GET"
    case .sseStreamingQuestion:
      "GET"
    case .resetState:
      "DELETE"
    case .summaryYoutube:
      "POST"
    }
  }
  
  private var queryItems: [URLQueryItem]? {
    
    let clientQueryItem = URLQueryItem(name: "client_id", value: Bundle.ALAN_API_KEY)
    
    switch api {
    case .question(let text),
         .plainStreamingQuestion(let text),
         .sseStreamingQuestion(let text):
      return [URLQueryItem(name: "content", value: text), clientQueryItem]
    default:
      return nil
    }
  }
  
  private var body: Data? {
    switch api {
    case .resetState:
      let params = ["client_id": Bundle.ALAN_API_KEY]
      return try? JSONSerialization.data(withJSONObject: params)
      
    default:
      return nil
    }
  }
  
  func asURLRequest() -> URLRequest {
    var components = URLComponents(
      url: baseURL.appendingPathComponent(path),
      resolvingAgainstBaseURL: false
    )!
    components.queryItems = queryItems
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = method
    request.httpBody = body
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    return request
  }
}
