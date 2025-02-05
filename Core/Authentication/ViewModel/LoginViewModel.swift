//
//  LoginViewModel.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/19.
//

import SwiftUI

class LoginViewModel: ObservableObject {
  
    @Published var email = ""
    @Published var password = ""
    
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
