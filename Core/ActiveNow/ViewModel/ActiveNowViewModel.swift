//
//  ActivuNowViewModel.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2025/02/07.
//

import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchAllUsers(limit: 10)
    }
}
