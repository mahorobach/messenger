//
//  ChatService.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2025/02/06.
//

import Foundation
import Firebase


struct ChatService {
        
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chaPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chaPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chaPartnerId).collection(currentUid)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-message").document(chaPartnerId)
        let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chaPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chaPartnerId,
            messageText: messageText,
            timestamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }

    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        let query = FirestoreConstants.MessagesCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            /*
             query.addSnapshotListener { snapshot, _ in ... }
             データベースの変更をリアルタイムで監視するリスナーを追加しています
             変更があるたびにこのクロージャーが実行されます
             snapshot は変更された時点でのデータのスナップショット
             _ は エラーパラメータを無視することを示します
             
             guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
             snapshot?.documentChanges でドキュメントの変更を取得
             .filter({ $0.type == .added}) で新しく追加されたメッセージのみをフィルタリング
             変更がない場合は処理を終了（guard 文による早期リターン）

             var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
             フィルタリングされた変更を Message オブジェクトに変換
             compactMap は変換に失敗した項目を除外
             try? はエラーが発生した場合に nil を返す
             Message.self は変換先の型を指定
             */
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
