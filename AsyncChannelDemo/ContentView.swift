//
//  ContentView.swift
//  AsyncChannelDemo
//
//  Created by Robert Ryan on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Start experiment") {
                ExperimentView()
            }
            .navigationTitle("ContentView")
        }
    }
}

#Preview {
    ContentView()
}
