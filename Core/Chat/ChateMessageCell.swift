//
//  ChateMessageCell.swift
//  MessengerTutorial
//
//  Created by 赤尾浩史 on 2023/10/19.
//

import SwiftUI

struct ChateMessageCell: View {
    let isFromCurrentUser: Bool
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                Text("This is test Message. アドビ株式会社　期限は今日です。　本当にありがとう")
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            }else {
                HStack(alignment:.bottom, spacing: 8){
                    CircularProfileImageView(user: User.MOCK_USER, size: .xxSmall)
                    
                    Text("This is test Message.長い話をしなければなりません。どんなに長くても、内容が濃いものであれば良い")
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChateMessageCell(isFromCurrentUser: true)
}
