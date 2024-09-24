//
//  HomeView.swift
//  LoopWatchAssignment
//
//  Created by Matt Free on 9/19/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(ViewModel.self) private var viewModel

    @State private var presentCreateListAlert = false
    @State private var newListName = ""

    var body: some View {
        NavigationStack {
            List(viewModel.lists) { list in
                NavigationLink {
                    DetailListView(itemList: list)
                        .environment(viewModel)
                } label: {
                    Text(list.name)
                }

            }
            .alert("New List", isPresented: $presentCreateListAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Create List") {
                    viewModel.createList(name: newListName)
                    newListName = ""
                }

                TextField("List name", text: $newListName)
            } message: {
                Text("Please enter a list name.")
            }
            .navigationTitle("Lists")
            .toolbar {
                ToolbarItem {
                    Button {
                        presentCreateListAlert = true
                    } label: {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(ViewModel.previewState)
}
