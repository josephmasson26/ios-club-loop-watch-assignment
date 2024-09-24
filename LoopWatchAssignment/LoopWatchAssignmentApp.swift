//
//  LoopWatchAssignmentApp.swift
//  LoopWatchAssignment
//
//  Created by Matt Free on 9/19/24.
//

import SwiftUI

@main
struct LoopWatchAssignmentApp: App {
    @State private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(viewModel)
        }
    }
}
