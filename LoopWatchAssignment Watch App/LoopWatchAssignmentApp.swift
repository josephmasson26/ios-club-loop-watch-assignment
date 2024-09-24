//
//  LoopWatchAssignmentApp.swift
//  LoopWatchAssignment Watch App
//
//  Created by Matt Free on 9/19/24.
//

import SwiftUI

@main
struct LoopWatchAssignment_Watch_AppApp: App {
    @State private var viewModel = WatchViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

// iphone uiud F0049948-E6DA-4C12-80E6-D653042914F9
// watch uiud 2455BDE0-7B88-414D-921B-69CFD91F74C6

// xcrun simctl pair 2455BDE0-7B88-414D-921B-69CFD91F74C6 F0049948-E6DA-4C12-80E6-D653042914F9
