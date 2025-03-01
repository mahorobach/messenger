//
//  User.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/18.
//

import Foundation
import FirebaseFirestore

struct User : Codable, Identifiable , Hashable{
    @DocumentID var uid: String?
    
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
    var firstName: String {
        let formatter = PersonNameComponentsFormatter()
        let components = formatter.personNameComponents(from: fullname)
        return components?.givenName ?? fullname
    }
    
}

extension User {
    static let MOCK_USER = User(fullname: "yamada taro", email: "taro@gmail.com", profileImageUrl: "momotarou")
}
