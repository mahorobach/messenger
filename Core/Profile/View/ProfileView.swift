//
//  ProfileView.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/18.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    var body: some View {
        VStack {
            //header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                       profileImage
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .large)
                    }
                    
                    
                }
                
                
                Text(user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            //list
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width:  24, height: 24)
                                .foregroundColor(option.imageBackgroundColor)
                            
                            Text(option.title)
                        }
                    }
                }
                
                Section {
                    Button("Log Out") {
                        AuthService.shared.signOut()
                        
                    }
                    Button("Delete Account"){
                    }
                }
                .foregroundColor(.red)
            }
            
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
