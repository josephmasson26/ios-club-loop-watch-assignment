import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: WatchViewModel
    @State private var showModal = false
    @State private var newListName = ""

    var body: some View {
        NavigationStack {
            List(viewModel.lists) { list in
                NavigationLink {
                    DetailListView(itemList: list).environmentObject(viewModel)
                } label: {
                    Text(list.name)
                }
            }
            .navigationTitle("Lists")
            .toolbar {
                ToolbarItem {
                    Button {
                        showModal = true
                    } label: {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                NewListView(newListName: $newListName) {
                    viewModel.addList(name: newListName)
                    newListName = ""
                }
            }
        }
    }
}

#Preview {
    ContentView()
}