//
//  Course.swift
//  FeatureA
//
//  Created by Piyush Sharma on 5/29/25.
//

import Foundation

public struct Course: Identifiable {
  public let id: String
  public let title: String

  public init(id: String, title: String) {
    self.id = id
    self.title = title
  }
}

