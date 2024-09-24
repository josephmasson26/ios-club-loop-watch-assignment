//
//  DetailListView.swift
//  LoopWatchAssignment
//
//  Created by Matt Free on 9/19/24.
//

import SwiftUI

struct DetailListView: View {
    @Environment(ViewModel.self) private var viewModel
    var itemList: ItemList

    @State private var presentCreateItemAlert = false
    @State private var newItemName = ""

    var body: some View {
        List(itemList.items) { item in
            HStack {
                Button {
                    viewModel.toggleItemAsCompleted(item, list: itemList)
                } label: {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                }

                Text(item.name)
            }
        }
        .alert("New Item", isPresented: $presentCreateItemAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Add Item") {
                viewModel.addItem(to: itemList, name: newItemName)
                newItemName = ""
            }

            TextField("Item name", text: $newItemName)
        } message: {
            Text("Please enter a item name.")
        }
        .navigationTitle(itemList.name)
        .toolbar {
            ToolbarItem {
                Button {
                    presentCreateItemAlert = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailListView(itemList: ViewModel.previewState.lists[0])
            .environment(ViewModel.previewState)
    }
}
