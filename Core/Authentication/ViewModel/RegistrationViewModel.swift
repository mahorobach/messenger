//
//  RegistrationViewModel.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/19.
//

import SwiftUI

class RegistrationViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }

}
