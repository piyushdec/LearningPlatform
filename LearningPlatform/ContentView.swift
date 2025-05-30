//
//  ContentView.swift
//  LearningPlatform
//
//  Created by Piyush Sharma on 5/29/25.
//

import SwiftUI
import FeatureAServices
import FeatureBServices
import FeatureCServices
import FeatureAUI
import FeatureBUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
          CourseView()
          CurriculaView()
        }
        .padding()
        .task {
          let courseService = CourseService()
          let currService = CurriculaService()
          let achievementService = AchievementService()
        }
    }
}

#Preview {
    ContentView()
}
