import SwiftUI

struct DetailListView: View {
    @EnvironmentObject private var viewModel: WatchViewModel
    var itemList: ItemList
    @State private var presentCreateItemAlert = false
    @State private var newItemName = ""
    @State private var showModal = false

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
        .sheet(isPresented: $showModal) {
            NewItemView(newItemName: $newItemName) {
                viewModel.addItem(to: itemList, name: newItemName)
                newItemName = ""
            }
        }
        .navigationTitle(itemList.name)
        .toolbar {
            ToolbarItem {
                Button {
                    showModal = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
}

struct DetailListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailListView(itemList: ItemList(name: "Sample List", items: []))
                .environmentObject(WatchViewModel())
        }
    }
}
