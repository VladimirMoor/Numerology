//
//  PreviewProvider.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() {}

    
    var messageListVM: MessageListViewModel {
        let messageVM = MessageListViewModel()
        messageVM.messages = [
            "Test message 1",
            "Test message 2",
            "Test message 3",
            "Test message 4",
            "Test message 3333",
            "Test message looooooooooooooooooooooong mesage here",
            "Test message 234234",
            "Test message sdfbwtwrt ety ety",
            "Test message trtr  trth r",
            "Test message ege  5 5 5 5",

        ]
        messageVM.isLoading = false
        messageVM.errorMessage = nil
        
        return messageVM
    }
    
}
