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
        Text(vm.messages[0])
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(vm: dev.messageListVM)
    }
}
