//
//  CurriculaService.swift
//  FeatureB
//
//  Created by Piyush Sharma on 5/29/25.
//

import FeatureBModels

public class CurriculaService {
  public init() {}

  public func fetchCurricula() -> [Curricula] {
    return [
      Curricula(id: "1", title: "Intro to iOS Developm,ent"),
      Curricula(id: "2", title: "Advanced SPM")
    ]
  }
}
