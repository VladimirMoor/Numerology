//
//  MessageListView.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

import SwiftUI

struct MessageListView: View {
    
    @ObservedObject var vm: MessageListViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("Messages")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.theme.blue)
                Spacer()
                Text("Error message here ")
                    .foregroundColor(Color.secondary)
            }
            .padding()
            .background(Color.theme.background.ignoresSafeArea(.all, edges: .top))
        }
        
        
        
//        List {
//            ForEach(0..<vm.messages.count) { index in
//                Text(vm.messages[index])
//            }
//        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            MessageListView(vm: dev.messageListVM)
            MessageListView(vm: dev.messageListVM).preferredColorScheme(.dark)
        }
       
    }
}
