//
//  ExperimentView.swift
//  AsyncChannelDemo
//
//  Created by Robert Ryan on 1/23/24.
//

import SwiftUI
import AsyncAlgorithms
import os.log

private let poi = OSSignposter(subsystem: "MyApp", category: .pointsOfInterest)

typealias AsyncClosure = () async -> Void

struct ExperimentView: View {
    @StateObject var viewModel = ExperimentViewModel()

    var body: some View {
        VStack {
            Button("Red")   { Task { await viewModel.addRed()   } }
            Button("Green") { Task { await viewModel.addGreen() } }
            Button("Blue")  { Task { await viewModel.addBlue()  } }
        }
        .task {
            await viewModel.monitorChannel()
        }
    }
}

@MainActor
class ExperimentViewModel: ObservableObject {
    let channel = AsyncChannel<AsyncClosure>()

    func monitorChannel() async {
        for await block in channel {
            await block()
        }
    }

    func addRed() async {
        poi.emitEvent(#function)
        await channel.send { await self.red() }
    }

    func addGreen() async {
        poi.emitEvent(#function)
        await channel.send { await self.green() }
    }

    func addBlue() async {
        poi.emitEvent(#function)
        await channel.send { await self.blue() }
    }

    func red() async {
        let state = poi.beginInterval(#function)
        defer { poi.endInterval(#function, state) }

        try? await Task.sleep(for: .seconds(3))
    }

    func green() async {
        let state = poi.beginInterval(#function)
        defer { poi.endInterval(#function, state) }

        try? await Task.sleep(for: .seconds(3))
    }

    func blue() async {
        let state = poi.beginInterval(#function)
        defer { poi.endInterval(#function, state) }

        try? await Task.sleep(for: .seconds(3))
    }
}
