//
//  ContentView.swift
//  LearningPlatform
//
//  Created by Piyush Sharma on 5/29/25.
//

import SwiftUI
import FeatureAUI
import FeatureAModels
import FeatureAServices
import FeatureBModels
import FeatureBServices
import FeatureBUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
        }
    }
}

#Preview {
    ContentView()
}
