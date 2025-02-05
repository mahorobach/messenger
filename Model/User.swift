//
//  User.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/18.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Codable, Identifiable , Hashable{
    @DocumentID var uid: String?
    
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
}

extension User {
    static let MOCK_USER = User(fullname: "yamada taro", email: "taro@gmail.com", profileImageUrl: "momotarou")
}
