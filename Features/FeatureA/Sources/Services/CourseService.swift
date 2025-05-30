//
//  CourseService.swift
//  FeatureA
//
//  Created by Piyush Sharma on 5/29/25.
//
import FeatureAModels

public class CourseService {
  public init() {}

  public func fetchCourses() -> [Course] {
    return [
      Course(id: "1", title: "Intro to Swift"),
      Course(id: "2", title: "Advanced SwiftUI")
    ]
  }
}
