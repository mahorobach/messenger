//
//  Constants.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2025/02/06.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
