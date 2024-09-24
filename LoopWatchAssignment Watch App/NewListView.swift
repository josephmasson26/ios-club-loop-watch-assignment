import SwiftUI

struct NewListView: View {
    @Binding var newListName: String
    @Environment(\.presentationMode) var presentationMode
    var onAdd: () -> Void

    var body: some View {
        VStack {
            Text("Enter New List Name")
                .font(.headline)
                .padding()

            TextField("List name", text: $newListName)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()

            Button("Add List") {
                onAdd()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .disabled(newListName.isEmpty)
        }
        .padding()
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView(newListName: .constant(""), onAdd: {})
    }
}