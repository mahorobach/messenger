//
//  InboxService.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2025/02/06.
//

import SwiftUI
import Firebase


class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessgaes() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            
            self.documentChanges = changes
        }
    }
}
