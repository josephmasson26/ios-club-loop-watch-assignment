import SwiftUI
import WatchConnectivity

@Observable
class ViewModel: NSObject, WCSessionDelegate {
    var lists: [ItemList]
    private var session: WCSession?

    init(lists: [ItemList] = []) {
        self.lists = lists
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
            print("Session Activated on Phone")
        }
    }
    
    // MARK: - User Intents
    /// Creates a new empty ItemList with the given name.
    func createList(name: String) {
        lists.append(.init(name: name))
        sendDataToWatch()
    }

    /// Adds an item with the given name to an ItemList.
    func addItem(to list: ItemList, name: String) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index].addItem(name)
            sendDataToWatch()
        }
    }

    /// Toggle an item as complete or incomplete.
    func toggleItemAsCompleted(_ item: ItemList.Item, list: ItemList) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index].toggleItemAsCompleted(item)
            sendDataToWatch()
        }
    }

    // MARK: - Watch Connectivity
    private func sendDataToWatch() {
        guard let session = session, session.isPaired, session.isWatchAppInstalled else { return }
        do {
            print("Sending data to watch")
            let data = try JSONEncoder().encode(lists)
            try session.updateApplicationContext(["lists": data])
            print("Data sent to watch")
        } catch {
            print("Failed sending data: \(error)")
        }
    }

    // // Delegate methods
    // func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    

    // WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let data = applicationContext["lists"] as? Data {
            do {
                lists = try JSONDecoder().decode([ItemList].self, from: data)
                print("Data received from Watch")
            } catch {
                print("Failed to decode data from Watch: \(error)")
            }
        }
    }
    
}

extension ViewModel {
    static var previewState: ViewModel {
        ViewModel(
            lists: [
                .init(
                    name: "List 1",
                    items: [.init(name: "Item 1"), .init(name: "Item 2")]
                ),
                .init(name: "List 2"),
            ]
        )
    }
}
