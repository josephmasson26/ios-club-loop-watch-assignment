import SwiftUI

@Observable
class ItemList: Identifiable, ObservableObject, Codable {
    var id: UUID = .init()
    var name: String
    var items: [Item]

    init(name: String, items: [Item] = []) {
        self.id = .init()
        self.name = name
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case id, name, items
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        items = try container.decode([Item].self, forKey: .items)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(items, forKey: .items)
    }

    struct Item: Identifiable, Codable {
        var id: UUID = .init()
        var name: String
        var isCompleted: Bool = false

        enum CodingKeys: String, CodingKey {
            case id, name, isCompleted
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
            name = try container.decode(String.self, forKey: .name)
            isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted) ?? false
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(isCompleted, forKey: .isCompleted)
        }

        init(name: String) {
            self.id = UUID()
            self.name = name
            self.isCompleted = false
        }
    }
    
    func addItem(_ name: String) {
        items.append(.init(name: name))
    }
    
    func toggleItemAsCompleted(_ item: Item) {
        if let index = items.firstIndex(where: { item.id == $0.id }) {
            items[index].isCompleted.toggle()
        }
    }
}