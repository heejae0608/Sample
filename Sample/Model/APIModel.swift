//
//  APIModel.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import Foundation

struct PostModel: Codable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
