//
//  InboxViewModel.swift
//  Messenger
//
//  Created by 赤尾浩史 on 2023/10/21.
//

import Foundation
import Combine
//import FirebaseFirestore


class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
}
