//
//  APIService.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import Foundation
import Alamofire

enum ServiceError: Error {
  case transportError(error: String?)
  case responseError
}

final class APIService {
  static let shared = APIService()
  
  func request<T: Decodable>(
    url: String,
    resultType: T.Type,
    method: HTTPMethod,
    parameter: [String: Any]? = nil) async throws -> T {
    let baseURL = url
    let request = AF.request(baseURL, method: method, parameters: parameter)
    let dataTask = request.serializingDecodable(resultType)
    
    switch await dataTask.result {
    case .success(let value):
      guard let response = await dataTask.response.response, (200...299).contains(response.statusCode) else {
        throw ServiceError.responseError
      }
      
      return value
    case .failure(let error):
      throw ServiceError.transportError(error: error.errorDescription)
    }
  }
  
  func fetchSamplePost(with id: Int) async throws -> PostModel {
    let url = "https://jsonplaceholder.typicode.com/posts/\(id)"

    do {
      let post = try await
      request(url: url, resultType: PostModel.self, method: .get)
      return post
    } catch {
      throw ServiceError.responseError
    }
  }
}
