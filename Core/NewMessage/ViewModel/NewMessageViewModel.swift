//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2023/10/22.
//

import Foundation
import Firebase
import FirebaseAuth

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter( {$0.id != currentUid} ) //ログインユーザーを排除した
    }
}
