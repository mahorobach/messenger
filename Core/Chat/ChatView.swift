//
//  ChatView.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/19.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    let user: User
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
            
            ForEach( 0 ... 15, id: \.self) { message  in
                ChateMessageCell(isFromCurrentUser: Bool.random())
            }
            
        }
        
        //message input view
        Spacer()
        
        ZStack(alignment: .trailing) {
            TextField("Message....", text: $messageText, axis: .vertical)
                .padding(12)
                .padding(.trailing, 40)
                .background(Color(.systemGroupedBackground))
                .clipShape(Capsule())
                .font(.subheadline)
            
            Button {
                print("Send message")
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
