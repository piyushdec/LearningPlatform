//
//  CurriculaUI.swift
//  FeatureB
//
//  Created by Piyush Sharma on 5/29/25.
//

import FeatureBServices
import SwiftUI

public struct CurriculaView: View {
  private let service = CurriculaService()

  public init() {}

  public var body: some View {
    List(service.fetchCurricula()) { curricula in
      Text(curricula.title)
    }
  }
}
