import Foundation

struct ItemList: Identifiable, Codable {
    var id = UUID()
    var name: String
    var items: [Item] = []

    init(name: String, items: [Item] = []) {
        self.id = .init()
        self.name = name
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case id, name, items
    }

    mutating func addItem(_ name: String) {
        items.append(.init(name: name))
    }

    
    mutating func toggleItemAsCompleted(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(items, forKey: .items)
    }



    struct Item: Identifiable, Codable {
        var id = UUID()
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
}
