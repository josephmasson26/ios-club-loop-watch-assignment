import SwiftUI
import WatchConnectivity

class WatchViewModel: NSObject, ObservableObject, WCSessionDelegate {
    @Published var lists: [ItemList] = []

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("Session Activated on Watch")
        }
    }

    // WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let data = applicationContext["lists"] as? Data {
            do {
                lists = try JSONDecoder().decode([ItemList].self, from: data)
                print("Data received from iPhone")
            } catch {
                print("Failed to decode data from iPhone: \(error)")
            }
        }
    }

    func addItem(to list: ItemList, name: String) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index].addItem(name)
            sendUpdatedListsToPhone()
        }
    }

    func toggleItemAsCompleted(_ item: ItemList.Item, list: ItemList) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index].toggleItemAsCompleted(item)
            sendUpdatedListsToPhone()
        }
    }

    func addList(name: String) {
        _ = ItemList(name: name, items: [])
        lists.append(ItemList(name: name))
        sendUpdatedListsToPhone()
    }

    private func sendUpdatedListsToPhone() {
        if WCSession.default.isReachable {
            do {
                let data = try JSONEncoder().encode(lists)
                let applicationContext: [String: Any] = ["lists": data]
                try WCSession.default.updateApplicationContext(applicationContext)
                print("Data sent to iPhone")
            } catch {
                print("Failed to send data to iPhone: \(error)")
            }
        }
    }
}
