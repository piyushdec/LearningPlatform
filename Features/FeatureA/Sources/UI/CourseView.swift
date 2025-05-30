//
//  CourseView.swift
//  FeatureA
//
//  Created by Piyush Sharma on 5/29/25.
//

import SwiftUI
import FeatureAServices

public struct CourseView: View {
  private let service = CourseService()

  public init() {}

  public var body: some View {
    List(service.fetchCourses()) { course in
      Text(course.title)
    }
  }
}
