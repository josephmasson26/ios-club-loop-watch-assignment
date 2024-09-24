import SwiftUI

struct NewItemView: View {
    @Binding var newItemName: String
    @Environment(\.presentationMode) var presentationMode
    var onAdd: () -> Void

    var body: some View {
        VStack {
            Text("Enter New Item Name")
                .font(.headline)
                .padding()

            TextField("Item name", text: $newItemName)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()

            Button("Add Item") {
                onAdd()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .disabled(newItemName.isEmpty)
        }
        .padding()
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemName: .constant(""), onAdd: {})
    }
}