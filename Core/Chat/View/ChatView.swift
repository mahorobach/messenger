//
//  ChatView.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/19.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel : ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            //header
            VStack {
                CircularProfileImageView(user: user, size: .xLarge)
                VStack(spacing: 4) {
                    Text(user.fullname)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Messenger")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
            }
            
            
            //message
            
            ForEach(viewModel.messages) { message  in
                ChateMessageCell(message: message)
            }
            
        }
        
        //message input view
        Spacer()
        
        ZStack(alignment: .trailing) {
            TextField("Message....", text: $viewModel.messageText, axis: .vertical)
                .padding(12)
                .padding(.trailing, 40)
                .background(Color(.systemGroupedBackground))
                .clipShape(Capsule())
                .font(.subheadline)
            
            Button {
                viewModel.sendMessage()
                viewModel.messageText = ""
            } label: {
                Text("Send")
                    .fontWeight(.semibold)
            }
            .padding()
            
        }
        
        
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
